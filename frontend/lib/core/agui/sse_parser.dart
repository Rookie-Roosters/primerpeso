import 'dart:async';
import 'dart:convert';

/// One decoded SSE event block.
///
/// `data` is the joined value of all `data:` lines (newline-separated).
/// `event` and `id` carry the optional `event:` / `id:` fields.
class SseEvent {
  const SseEvent({required this.data, this.event, this.id});

  final String data;
  final String? event;
  final String? id;
}

/// Parses a raw byte stream from a `text/event-stream` response into
/// discrete [SseEvent] blocks.
///
/// Implements the minimal SSE rules we need: line splitting, multi-line
/// `data:` accumulation, blank-line dispatch, `:` comment / heartbeat
/// lines are skipped. Reconnection (`retry:`) and last-event-id replay
/// are intentionally out of scope for the skeleton.
Stream<SseEvent> parseSse(Stream<List<int>> bytes) async* {
  final lines = bytes.transform(utf8.decoder).transform(const LineSplitter());
  final dataBuf = StringBuffer();
  String? eventName;
  String? eventId;
  var hasContent = false;

  await for (final raw in lines) {
    if (raw.isEmpty) {
      if (hasContent) {
        yield SseEvent(data: dataBuf.toString(), event: eventName, id: eventId);
      }
      dataBuf.clear();
      eventName = null;
      eventId = null;
      hasContent = false;
      continue;
    }
    if (raw.startsWith(':')) {
      // Comment / heartbeat — ignore.
      continue;
    }
    final colon = raw.indexOf(':');
    final field = colon == -1 ? raw : raw.substring(0, colon);
    var value = colon == -1 ? '' : raw.substring(colon + 1);
    if (value.startsWith(' ')) {
      value = value.substring(1);
    }

    switch (field) {
      case 'data':
        if (dataBuf.isNotEmpty) dataBuf.write('\n');
        dataBuf.write(value);
        hasContent = true;
      case 'event':
        eventName = value;
        hasContent = true;
      case 'id':
        eventId = value;
        hasContent = true;
      case 'retry':
        // Reconnection hint — ignored for now.
        break;
      default:
        // Unknown field — ignored.
        break;
    }
  }

  if (hasContent) {
    yield SseEvent(data: dataBuf.toString(), event: eventName, id: eventId);
  }
}
