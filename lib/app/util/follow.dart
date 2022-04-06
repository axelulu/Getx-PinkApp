import 'package:pink_acg/app/http/dao/coin_dao.dart';
import 'package:pink_acg/app/http/dao/favorite_dao.dart';
import 'package:pink_acg/app/http/dao/follow_dao.dart';
import 'package:pink_acg/app/http/dao/like_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

follow(int userId, follow) async {
  try {
    var result = await FollowDao.get(userId);
    if (result["code"] == 1000) {
      follow();
      showToast("关注成功!");
    } else {
      showWarnToast(result['msg']);
    }
  } on NeedAuth catch (e) {
    showWarnToast(e.message);
  } on NeedLogin catch (e) {
    showWarnToast(e.message);
  } on PinkNetError catch (e) {
    showWarnToast(e.message);
  }
}

unFollow(int userId, unFollow) async {
  try {
    var result = await FollowDao.remove(userId);
    if (result["code"] == 1000) {
      unFollow();
      showToast("取消关注成功!");
    } else {
      showWarnToast(result['msg']);
    }
  } on NeedAuth catch (e) {
    showWarnToast(e.message);
  } on NeedLogin catch (e) {
    showWarnToast(e.message);
  } on PinkNetError catch (e) {
    showWarnToast(e.message);
  }
}

///点赞
doLike(int postId, doLike) async {
  try {
    var result = await LikeDao.get(postId);
    if (result["code"] == 1000) {
      doLike();
      showToast("喜欢成功!");
    } else {
      showWarnToast(result['msg']);
    }
  } on NeedAuth catch (e) {
    showWarnToast(e.message);
  } on NeedLogin catch (e) {
    showWarnToast(e.message);
  } on PinkNetError catch (e) {
    showWarnToast(e.message);
  }
}

///取消点赞
doUnLike(int postId, doUnLike) async {
  try {
    var result = await LikeDao.remove(postId);
    if (result["code"] == 1000) {
      doUnLike();
      showToast("讨厌成功!");
    } else {
      showWarnToast(result['msg']);
    }
  } on NeedAuth catch (e) {
    showWarnToast(e.message);
  } on NeedLogin catch (e) {
    showWarnToast(e.message);
  } on PinkNetError catch (e) {
    showWarnToast(e.message);
  }
}

///投币
void onCoin(int postId, onCoin) async {
  try {
    var result = await CoinDao.get(postId);
    if (result["code"] == 1000) {
      onCoin();
      showToast("投币成功!");
    } else {
      showWarnToast(result["msg"]);
    }
  } on NeedAuth catch (e) {
    showWarnToast(e.message);
  } on NeedLogin catch (e) {
    showWarnToast(e.message);
  } on PinkNetError catch (e) {
    showWarnToast(e.message);
  }
}

///收藏
void onFavorite(bool isFavorite, int postId, onFavorite) async {
  try {
    var result;
    if (isFavorite) {
      result = await FavoriteDao.remove(postId);
    } else {
      result = await FavoriteDao.get(postId);
    }
    if (result["code"] == 1000) {
      onFavorite();
    } else {
      showWarnToast(result["msg"]);
    }
  } on NeedAuth catch (e) {
    showWarnToast(e.message);
  } on NeedLogin catch (e) {
    showWarnToast(e.message);
  } on PinkNetError catch (e) {
    showWarnToast(e.message);
  }
}
