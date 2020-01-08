import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_daos.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_mapper.dart';
import 'package:karate_stars_app/src/news/data/local/social_news_models.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

class SocialNewsFloorDataSource extends CacheDataSource
    implements CacheableDataSource<SocialNews> {
  final SocialNewsDao _socialNewsDao;
  final SocialUsersDao _socialUsersDao;
  final _mapper = SocialNewsMapper();

  SocialNewsFloorDataSource(
      this._socialNewsDao, this._socialUsersDao, int maxCacheTime)
      : super(maxCacheTime);

  @override
  Future<List<SocialNews>> getAll() async {
    final socialUsers = await _socialUsersDao.findAll();
    final newsList = await _socialNewsDao.findAll();

    return newsList.map((news) {
      final source =
          socialUsers.firstWhere((src) => src.id == news.socialUserId);

      return _mapper.mapNewsToDomain(news, source);
    }).toList();
  }

  @override
  Future<void> save(List<SocialNews> items) async {
    final socialUsersDBToSave =
        items.map((item) => _mapper.mapSocialUserToDB(item.user)).toList();

    _socialUsersDao.insertAll(socialUsersDBToSave.toSet().toList());

    final socialUsersDB = await _socialUsersDao.findAll();

    final newsDB = items.map((item) {
      final SocialUserDB socialUserDB = socialUsersDB
          .firstWhere((user) => user.userName == item.user.userName);
      return _mapper.mapNewsToDB(item, socialUserDB.id);
    }).toList();

    _socialNewsDao.insertAll(newsDB);
  }

  @override
  Future<bool> areValidValues() async {
    final data = await _socialNewsDao.findAll();
    return !super.areDirty(data);
  }

  @override
  Future<void> invalidate() async {
    _socialNewsDao.deleteAll();
    _socialUsersDao.deleteAll();
  }
}
