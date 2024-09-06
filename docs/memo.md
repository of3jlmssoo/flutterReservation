# Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## memo

- theme
- go_router_builder
- freezedでfirestore関連情報を固める
  - jsonの位置付け確認する
  - 日付型問題確認する
- riverpod
  collection毎にriverpod providerを作成
  <https://parthpanchal53.medium.com/flutter-firebase-firestore-crud-app-using-riverpod-981811e2a73d>
- <https://zenn.dev/kisia_flutter/articles/c9720c41c9ceff>
- <https://qiita.com/kurogoma939/items/0b60418497b2f0eb7db0>
- routerで画面制御

## 画面

- ログイン画面 login screen
- メイン画面 main screen
- 新規予約画面 new reservation screen
  - 施設詳細画面 facility selection screen
  - 予約画面-日付選択 (select date)
  - 予約画面-必要情報入力 reservation input screen
  - 案内表示画面 reservation confirmation screen
- 予約状況画面 reservation status screen
  - 予約詳細画面 reservation details screen
- 利用実績画面
- ユーザー情報画面 user information screen
  - ユーザー詳細情報画面 user information update screen

```text
@riverpod
./src/features/jobs/presentation/jobs_screen/jobs_screen_controller.dart:@riverpod
./src/features/jobs/presentation/job_entries_screen/job_entries_list_controller.dart:@riverpod
./src/features/jobs/presentation/edit_job_screen/edit_job_screen_controller.dart:@riverpod
./src/features/jobs/data/jobs_repository.dart:@riverpod
./src/features/jobs/data/jobs_repository.dart:@riverpod
./src/features/entries/presentation/entry_screen/entry_screen_controller.dart:@riverpod
./src/features/entries/application/entries_service.dart:@riverpod
./src/features/entries/application/entries_service.dart:@riverpod
./src/features/onboarding/presentation/onboarding_controller.dart:@riverpod
./src/features/authentication/data/firebase_auth_repository.dart:@riverpod
./src/routing/app_router.dart:@riverpod

instance
./src/features/jobs/data/jobs_repository.dart:  return JobsRepository(FirebaseFirestore.instance);
./src/features/entries/data/entries_repository.dart:  return EntriesRepository(
FirebaseFirestore.instance);
./src/features/authentication/data/firebase_auth_repository.dart:  return FirebaseAuth.instance;
./main.dart:  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {

jobs_repository.dart
class JobsRepositoryはwithout @riverpod。この中にFuture<void> addJob()とかCRUD系ファンクションあり
この後にProvidersが定義される

- @Riverpod(keepAlive: true) JobsRepository jobsRepository(JobsRepositoryRef ref) {
- @riverpodQuery<Job> jobsQuery(JobsQueryRef ref) {
- @riverpod Stream<Job> jobStream(JobStreamRef ref, JobID jobId) {

jobs_screen_controller.dart
で更に@riverpodでJobsScreenControllerを定義。ファンクションはdeleteJob()のみ。

jobsRepositoryProvider
./src/features/jobs/presentation/jobs_screen/jobs_screen_controller.dart:    final repository =
ref.read(jobsRepositoryProvider);
./src/features/jobs/presentation/edit_job_screen/edit_job_screen_controller.dart:    final
repository = ref.read(jobsRepositoryProvider);
./src/features/jobs/data/jobs_repository.g.dart:final jobsRepositoryProvider =
Provider<JobsRepository>.internal(
./src/features/jobs/data/jobs_repository.g.dart:  name: r'jobsRepositoryProvider',
./src/features/jobs/data/jobs_repository.dart:  final repository = ref.watch(
jobsRepositoryProvider);
./src/features/jobs/data/jobs_repository.dart:  final repository = ref.watch(
jobsRepositoryProvider);
./src/features/entries/application/entries_service.dart:    jobsRepository: ref.watch(
jobsRepositoryProvider),

JobsScreenControllerProvider
./src/features/jobs/presentation/jobs_screen/jobs_screen.dart:
jobsScreenControllerProvider,
./src/features/jobs/presentation/jobs_screen/jobs_screen.dart:                    .read(
jobsScreenControllerProvider.notifier)
./src/features/jobs/presentation/jobs_screen/jobs_screen_controller.g.dart:String _
$jobsScreenControllerHash() =>
./src/features/jobs/presentation/jobs_screen/jobs_screen_controller.g.dart:final
jobsScreenControllerProvider =
./src/features/jobs/presentation/jobs_screen/jobs_screen_controller.g.dart:  name:
r'jobsScreenControllerProvider',
./src/features/jobs/presentation/jobs_screen/jobs_screen_controller.g.dart:      : _
$jobsScreenControllerHash,

collection
./lib/src/features/jobs/data/jobs_repository.dart:      _firestore.collection(jobsPath(uid)).add({
./lib/src/features/jobs/data/jobs_repository.dart:    final entriesRef = firestore.collection(
entriesPath(uid));
./lib/src/features/jobs/data/jobs_repository.dart:      _firestore.collection(jobsPath(uid))
.withConverter(
./lib/src/features/entries/data/entries_repository.dart:      _firestore.collection(entriesPath(
uid)).add({
./lib/src/features/entries/data/entries_repository.dart:        _firestore.collection(entriesPath(
uid)).withConverter<Entry>(

watchJob
./lib/src/features/jobs/data/jobs_repository.dart:  Stream<Job> watchJob({required UserID uid,
required JobID jobId}) =>
./lib/src/features/jobs/data/jobs_repository.dart:  Stream<List<Job>> watchJobs({required UserID
uid}) => queryJobs(uid: uid)
./lib/src/features/jobs/data/jobs_repository.dart:  return repository.watchJob(uid: user.uid, jobId:
jobId);
./lib/src/features/entries/application/entries_service.dart:        jobsRepository.watchJobs(uid:
uid),

cd projects/flutter-work/reservations2
flutter pub run build_runner watch

cd projects/flutter-work/reservations2
firebase emulators:start --import ./emulators_data --export-on-exit
```
