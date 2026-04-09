---
name: flutter-shard-state
description: Implement, refactor, review, or explain Flutter state management with the `shard` package. Use when adding or migrating feature state from Cubit, BLoC, Provider, or ChangeNotifier to `Shard`, `FutureShard`, `StreamShard`, `PersistentShard`, or `SimplePersistentShard`; wiring `ShardProvider`, `MultiShardProvider`, `ShardBuilder`, `ShardSelector`, or `AsyncShardBuilder`; or handling `AsyncValue`, response caching, persistence, observers, debounce or throttle, or `ShardLocator`.
---

# Flutter Shard State

Use Shard's package-native API and lifecycle. Do not recreate a BLoC layer on top of Shard unless the repository already depends on that abstraction.

Read [references/shard-patterns.md](references/shard-patterns.md) when you need copy-ready examples for synchronous state, async state, persistence, caching, observers, or Cubit-to-Shard migration.

## Default Workflow

1. Identify the state shape and lifetime first.
2. Choose the smallest shard type that matches the problem.
3. Keep mutation methods and side effects inside the shard, not the widget.
4. Scope providers to the feature or route that needs them.
5. Prefer selectors over whole-state rebuilds.
6. Preserve Shard naming and lifecycle hooks instead of generic BLoC conventions.

## Choose the Right Shard

- Use `Shard<T>` for synchronous feature state and imperative commands like counters, forms, filters, toggles, and local view models.
- Use `FutureShard<T>` for fetch-on-init or manually refreshed async data. Treat its state as `AsyncValue<T>`.
- Use `StreamShard<T>` for subscriptions, Firestore snapshots, sockets, or any live feed that should re-emit over time.
- Use `SimplePersistentShard<T>` when the entire state can be persisted directly.
- Use `PersistentShard<T, K>` when only part of the state should be persisted, or when the persisted shape differs from the in-memory state.

Default to `FutureShard` or `StreamShard` instead of inventing custom loading enums when the feature is primarily async.

## Model the State Correctly

- Keep state immutable where practical.
- Call `emit(newState)` for normal updates. Rely on the built-in equality guard to skip redundant rebuilds.
- Override `stateEquals(a, b)` when the state is complex and default equality is not good enough.
- Call `emitForce(state)` only when you intentionally need to bypass equality, such as after in-place mutation in legacy code.
- Use `addError(error, stackTrace)` for non-fatal errors that should reach observers without aborting the whole flow.
- Override `onInit`, `onChange`, `onError`, and `dispose` only when the feature needs them.
- Call `super.onChange(...)` and `super.onError(...)` when overriding observer hooks so the global observer still receives events.

## Wire the UI with Package-Native Widgets

- Use `ShardProvider(create: ...)` when the widget tree should own the shard lifecycle. Shard calls `onInit()` after creation and disposes the shard automatically.
- Use `ShardProvider.value(value: existingShard)` only when an existing object owns the shard lifecycle.
- Use `MultiShardProvider` when a feature needs multiple shard instances.
- Use `context.read<T>()` in callbacks and command handlers.
- Use `ShardSelector` when a widget only needs one field or a derived value from the state.
- Use `ShardBuilder` when the widget truly depends on the whole state or when `buildWhen`, `listenWhen`, or `listener` semantics are useful.
- Use `AsyncShardBuilder` for `FutureShard` and `StreamShard` unless pattern matching on `AsyncValue` gives clearer UI logic.

Prefer placing the provider at the route or feature boundary instead of the app root unless the shard is truly app-wide.

## Use Async, Cache, and Persistence Deliberately

- Remember that `FutureShard` caching is enabled by default.
- Override `cacheKey`, `cacheTTL`, or `cacheService` only when the default runtime-type cache is not specific enough.
- Call `refresh()` to invalidate cache and fetch fresh data.
- Call `refresh(invalidateCache: false)` when the UI should keep cached data visible while fetching again.
- Call `StreamShard.refresh()` to cancel the current subscription and resubscribe.
- Remember that the package does not ship a storage backend. If persistence is needed, implement `StateStorage` with SharedPreferences, Hive, SQLite, or another project-approved backend.
- Use `SimplePersistentShard` for primitive or fully serializable state.
- Use `PersistentShard<T, K>` plus `toPersistence()` and `onLoadComplete()` when only part of the state should survive restarts.

## Use Observers and the Locator Sparingly

- Set `Shard.observer` in `main()` for app-wide logging, analytics, or error reporting.
- Use `ShardLocator.registerSingleton` and `registerLazySingleton` for app-wide services only when the repo already accepts service-locator usage.
- Prefer constructor injection into shards when the dependency graph is small and explicit.
- Call `ShardLocator.reset()` in tests that depend on locator state.

## Migrate from Cubit or BLoC Carefully

- Map `Cubit<State>` to `Shard<State>` when the feature is synchronous.
- Map `BlocProvider` to `ShardProvider` and `MultiBlocProvider` to `MultiShardProvider`.
- Map `BlocBuilder` to `ShardBuilder` or, preferably, `ShardSelector` when only part of the state matters.
- Map async fetch cubits to `FutureShard<T>` when the feature mostly represents loading, data, and error.
- Map stream-driven blocs to `StreamShard<T>`.
- Map `HydratedCubit`-style persistence to `SimplePersistentShard<T>` or `PersistentShard<T, K>`.
- Keep public methods task-oriented like `increment()`, `toggleDarkMode()`, `submit()`, or `refresh()`. Do not expose raw event objects unless the repo already uses that style.

## Validation Checklist

- Verify the shard type matches the problem shape.
- Verify provider placement gives every consumer access without keeping state alive too long.
- Verify selectors return stable, equality-friendly values.
- Verify async UI handles loading, data, and error explicitly.
- Verify persistence code uses a real `StateStorage` implementation from the project.
- Verify overridden hooks still call `super` where required.
