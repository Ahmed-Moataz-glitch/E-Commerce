# Flutter Clean Architecture Project Skill

Use this guide when working with Flutter projects in AI coding tools such as Claude, Codex, Cursor, or similar assistants. The preferred default architecture is feature-first clean architecture with `data`, `domain`, and `presentation` layers.

## First Steps

Before changing code, inspect the project structure and learn the existing patterns.

- Read `pubspec.yaml` to identify dependencies, SDK version, assets, and code generators.
- Read `lib/main.dart` to understand app initialization, routing, dependency setup, themes, and startup logic.
- Check `README.md`, `analysis_options.yaml`, and any existing docs.
- Search the `lib/` folder to identify architecture style, state management, naming conventions, and feature layout.
- Check `test/` to understand the current testing approach.

If the project already uses feature-first clean architecture, follow it exactly. If the project is new or has no clear structure, create and use the architecture described below.

## Default Architecture

Use feature-first clean architecture:

```text
lib/
  core/
    utils/
    views/
      pages/
      widgets/
  features/
    feature_name/
      data/
        api/
        model/
        repo/
          data_source/
          repo/
      domain/
        entities/
        repo/
          data_source/
          repo/
        use_case/
      presentation/
        view/
          pages/
          widgets/
        view_model/
```

Each feature should be independent and should contain its own data, domain, and presentation code.

## Layer Responsibilities

`presentation` layer:

- Flutter pages and widgets.
- Cubits and state classes.
- User interaction and UI state.
- No direct HTTP calls.
- No direct database/storage calls unless the existing project intentionally does this.

`domain` layer:

- Entities.
- Repository contracts.
- Data source contracts if the project keeps them there.
- Use cases.
- Business rules.
- No Flutter widget code.
- No direct API implementation.

`data` layer:

- API classes.
- DTO/model classes.
- Data source implementations.
- Repository implementations.
- JSON parsing.
- Local storage implementation.

`core` layer:

- App routes.
- Dependency injection setup.
- Constants.
- Colors/assets/theme helpers.
- Secure storage helpers.
- Shared widgets.
- Shared result/error wrappers.

## Required Feature Flow

When adding a new feature or async action, use this flow:

1. UI widget/page calls a Cubit method.
2. Cubit calls a use case.
3. Use case calls a repository contract.
4. Repository implementation calls a data source contract.
5. Data source implementation calls an API class or local storage.
6. API/local storage returns a result.
7. Cubit emits loading, success, or error states.

Do not skip layers for major features.

## Naming Conventions

Use these names unless the existing project has a stronger convention:

- API class: `FeatureApi`
- Data source contract: `FeatureDataSource`
- Data source implementation: `FeatureDataSourceImpl`
- Repository contract: `FeatureRepo`
- Repository implementation: `FeatureRepoImpl`
- Use case: `ActionNameUseCase`
- Cubit: `FeatureCubit`
- State file: `feature_state.dart`
- Page: `feature_page.dart`
- Widget: `feature_item_widget.dart`
- Entity: `feature_entity.dart`
- DTO/model: `feature_dto.dart` or `feature_model.dart`

## State Management

Use `flutter_bloc` with Cubit as the default state management approach.

Cubit rules:

- Keep UI logic in widgets and business flow in Cubits/Blocs.
- Emit loading, success, and error states for async actions.
- Keep state classes consistent with existing style.
- Use simple sealed state classes unless the project uses Equatable, Freezed, or another state style.
- Cubits should receive use cases through constructor injection.

## API And Data Rules

Keep network code outside widgets.

Typical flow:

1. UI triggers an action.
2. State manager calls a repository, service, or use case.
3. Repository/service calls API or local storage.
4. Result is mapped into app models/entities.
5. UI responds to loading, success, and error states.

When editing API logic:

- Use the existing HTTP client/package. If there is no existing choice, use `http` for simple REST APIs.
- Keep base URLs and endpoints in the existing config/constants location.
- Parse JSON with typed models when the project already uses models.
- Handle non-success status codes clearly.
- Avoid swallowing exceptions silently.
- Do not hardcode secrets, API keys, tokens, or passwords.
- Return a consistent result wrapper such as `ApiResult<T>`, `ApiSuccess<T>`, and `ApiError<T>` when the project uses that pattern.

DTO/model classes should map API JSON into domain entities.

Domain entities should represent the clean app data shape used by Cubits and UI.

## Authentication And Tokens

For auth flows:

- Store access tokens and refresh tokens only in secure storage when available.
- Refresh expired access tokens through the existing auth repository/service.
- After a successful refresh, save the new access token and refresh token if the API returns both.
- On refresh failure, clear invalid auth state if the project has a logout/session-expired flow.
- Never print tokens in production logs.

## Local Storage

Use storage according to sensitivity:

- Secure tokens and credentials: secure storage.
- Small preferences and flags: shared preferences.
- Structured local data: Hive, Isar, SQLite, Drift, or the project's existing database layer.

If using generated adapters or schemas, regenerate code after model changes.

## Code Generation

Check for generated files and tools:

- `build_runner`
- `json_serializable`
- `freezed`
- `hive_generator`
- `riverpod_generator`
- `injectable_generator`

Do not manually edit generated files such as:

- `*.g.dart`
- `*.freezed.dart`
- generated plugin registrants

After changing annotated models/providers/adapters, run the project's generation command, commonly:

```bash
dart run build_runner build --delete-conflicting-outputs
```

or:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Routing And Navigation

Prefer centralized route constants and a single route registration location.

When adding a new page:

1. Add a route constant.
2. Add the route case/registration.
3. Pass page arguments with a clear typed object or a map, matching the existing project style.
4. Avoid scattering route strings directly through widgets.

If the project already uses `go_router`, `auto_route`, or another router, follow that package while keeping route names centralized.

## UI Guidelines

- Reuse existing widgets, colors, typography, spacing, and theme tokens.
- Keep widgets small when the surrounding code does so.
- Keep responsive behavior consistent with the app's chosen package or layout style.
- Use existing asset folders and update `pubspec.yaml` only when needed.
- Avoid large visual redesigns unless requested.
- Check mobile layouts for overflow, especially forms, cards, buttons, and long text.
- Keep shared widgets in `core/views/widgets` or the project's shared widgets folder.
- Keep feature-only widgets inside the feature's `presentation/view/widgets` folder.

## Dependency Injection

Use dependency injection for APIs, data sources, repositories, use cases, and Cubits.

Preferred default:

- Use `get_it` if available.
- Register APIs first.
- Register data sources after APIs.
- Register repositories after data sources.
- Register use cases after repositories.
- Register Cubits as factories.

Example order:

```text
FeatureApi
FeatureDataSource
FeatureRepo
ActionUseCase
FeatureCubit
```

Do not instantiate repositories, use cases, or APIs directly inside widgets.

## Common Commands

Install dependencies:

```bash
flutter pub get
```

Format code:

```bash
dart format .
```

Analyze code:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Run the app:

```bash
flutter run
```

Build Android APK:

```bash
flutter build apk
```

Build web:

```bash
flutter build web
```

## Before Finishing

Before marking work complete:

- Format changed Dart files.
- Run `flutter analyze` when possible.
- Run relevant tests when behavior changed.
- Confirm new dependencies are justified and added to `pubspec.yaml`.
- Confirm generated code is updated when needed.
- Confirm assets are declared in `pubspec.yaml`.
- Confirm no secrets or tokens were added to source code.
- Confirm the change follows feature-first clean architecture.
- Confirm new dependencies are registered in dependency injection.
- Confirm new routes are registered centrally.

## AI Assistant Behavior

When using this skill:

- Be specific about which files were changed.
- Explain how the change fits clean architecture.
- Prefer small, safe changes over broad rewrites.
- Ask only when required information cannot be inferred safely.
- Do not remove unrelated code.
- Do not refactor unrelated files while solving a narrow task.
- If a command fails or times out, report that clearly and continue with the best available verification.
- When creating new code, default to clean architecture with Cubit, use cases, repositories, data sources, APIs, and dependency injection.
