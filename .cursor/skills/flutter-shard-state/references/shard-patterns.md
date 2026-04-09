# Shard Patterns

Use these examples when writing or reviewing Flutter code that depends on `package:shard/shard.dart`.

## Install

```yaml
dependencies:
  shard: ^1.0.0
```

```dart
import 'package:shard/shard.dart';
```

## Plain Shard

Use `Shard<T>` for synchronous state and imperative commands.

```dart
class CounterShard extends Shard<int> {
  CounterShard() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}
```

```dart
ShardProvider<CounterShard>(
  create: CounterShard.new,
  child: const CounterScreen(),
)
```

```dart
ShardSelector<CounterShard, int, int>(
  selector: (count) => count,
  builder: (context, count) => Text('$count'),
)
```

## FutureShard

Use `FutureShard<T>` when the feature should fetch once on init and optionally refresh.

```dart
class UserShard extends FutureShard<User> {
  UserShard({
    required this.userId,
    required this.repository,
  });

  final String userId;
  final UserRepository repository;

  @override
  String get cacheKey => 'user_$userId';

  @override
  Duration get cacheTTL => const Duration(minutes: 30);

  @override
  Future<User> build() => repository.getUser(userId);
}
```

```dart
AsyncShardBuilder<UserShard, User>(
  onLoading: (context) => const CircularProgressIndicator(),
  onData: (context, user) => Text(user.name),
  onError: (context, error, stackTrace) => Text('Error: $error'),
)
```

Use `refresh()` to invalidate cache. Use `refresh(invalidateCache: false)` to fetch again while keeping cached data visible.

## StreamShard

Use `StreamShard<T>` when the source is continuous.

```dart
class MessagesShard extends StreamShard<List<Message>> {
  MessagesShard({
    required this.repository,
    required this.chatId,
  });

  final ChatRepository repository;
  final String chatId;

  @override
  Stream<List<Message>> build() => repository.watchMessages(chatId);
}
```

`refresh()` cancels the current subscription and subscribes again.

## AsyncValue

`FutureShard` and `StreamShard` expose `AsyncValue<T>` state.

```dart
ShardBuilder<UserShard, AsyncValue<User>>(
  builder: (context, asyncValue) {
    return switch (asyncValue) {
      AsyncLoading(previousData: final stale?)
          => Column(
              children: [
                Text(stale.name),
                const CircularProgressIndicator(),
              ],
            ),
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncData(:final data) => Text(data.name),
      AsyncError(:final error, previousData: final stale?)
          => Column(
              children: [
                Text(stale.name),
                Text('Refresh failed: $error'),
              ],
            ),
      AsyncError(:final error) => Text('Error: $error'),
    };
  },
)
```

## Simple Persistence

Use `SimplePersistentShard<T>` when the entire state is persisted.

```dart
class CounterShard extends SimplePersistentShard<int> {
  CounterShard()
      : super(
          0,
          storageFactory: SharedPreferencesStorage.getInstance,
          serializer: const IntSerializer(),
        );

  @override
  String get persistenceKey => 'counter';

  void increment() => emit(state + 1);
}
```

## Partial Persistence

Use `PersistentShard<T, K>` when only a slice of the state should survive restarts.

```dart
class TodoShard extends PersistentShard<TodoState, List<Todo>> {
  TodoShard()
      : super(
          const TodoState(status: TodoStatus.loading, todos: []),
          storageFactory: SharedPreferencesStorage.getInstance,
          serializer: stateSerializer<List<Todo>>(
            fromJson: (json) => (json as List)
                .map((item) => Todo.fromJson(item as Map<String, dynamic>))
                .toList(),
            toJson: (todos) => todos.map((todo) => todo.toJson()).toList(),
          ),
        );

  @override
  String get persistenceKey => 'todos';

  @override
  List<Todo> toPersistence(TodoState state) => state.todos;

  @override
  void onLoadComplete(List<Todo>? data) {
    emit(state.copyWith(
      status: TodoStatus.loaded,
      todos: data ?? const [],
    ));
  }
}
```

## Storage Backend Reminder

Shard does not include a storage backend. Implement `StateStorage` in the app:

```dart
class SharedPreferencesStorage implements StateStorage {
  SharedPreferencesStorage._(this._prefs);

  final SharedPreferences _prefs;

  static Future<SharedPreferencesStorage> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPreferencesStorage._(prefs);
  }

  @override
  Future<void> save(String key, String value) => _prefs.setString(key, value);

  @override
  Future<String?> load(String key) async => _prefs.getString(key);
}
```

## Selectors over Whole-State Rebuilds

Prefer `ShardSelector` when only one value matters.

```dart
ShardSelector<TodoShard, TodoState, int>(
  selector: (state) => state.todos.where((todo) => !todo.completed).length,
  builder: (context, activeCount) => Text('Active: $activeCount'),
)
```

Use `ShardBuilder` when the widget genuinely needs the whole state, or when `buildWhen`, `listenWhen`, or `listener` improves clarity.

## Observers

```dart
class LoggingObserver extends ShardObserver {
  @override
  void onChange<T>(Shard<T> shard, T previousState, T currentState) {
    debugPrint('${shard.runtimeType}: $previousState -> $currentState');
  }

  @override
  void onError<T>(Shard<T> shard, Object error, StackTrace? stackTrace) {
    debugPrint('${shard.runtimeType}: $error');
  }
}

void main() {
  Shard.observer = LoggingObserver();
  runApp(const MyApp());
}
```

When overriding `onChange` or `onError` inside a shard, call `super`.

## Debounce and Throttle

Use debounce for search or text input and throttle for scroll or repeated taps.

```dart
debounce(
  'search',
  () => performSearch(query),
  duration: const Duration(milliseconds: 500),
);

throttle(
  'loadMore',
  () => loadMore(),
  duration: const Duration(seconds: 1),
);
```

## ShardLocator

Use the built-in locator only when the codebase accepts that pattern.

```dart
void main() {
  ShardLocator.registerSingleton(ApiClient());
  ShardLocator.registerLazySingleton<UserRepository>(
    () => UserRepository(ShardLocator.get<ApiClient>()),
  );
  runApp(const MyApp());
}
```

Call `ShardLocator.reset()` in tests that need clean locator state.

## Cubit to Shard Mapping

- `Cubit<State>` -> `Shard<State>`
- `BlocProvider` -> `ShardProvider`
- `MultiBlocProvider` -> `MultiShardProvider`
- `BlocBuilder` -> `ShardBuilder` or `ShardSelector`
- `HydratedCubit` -> `SimplePersistentShard<T>` or `PersistentShard<T, K>`
- async data cubit -> `FutureShard<T>`
- stream-driven bloc -> `StreamShard<T>`
