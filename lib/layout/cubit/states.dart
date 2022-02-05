abstract class SocialStates{}
class SocialInit extends SocialStates{}
class SocialGetUserLoading extends SocialStates{}
class SocialGetUserSuccess extends SocialStates{}
class SocialGetUserError extends SocialStates{
  final error;
  SocialGetUserError(this.error);
}
class SocialChangeBottomNavState extends SocialStates{}
class SocialUploadPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}
class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateProfileLoadingState extends SocialStates{}
class SocialUpdateProfileErrorState extends SocialStates{}

//Post
class SocialUpdatePostImageLoadingState extends SocialStates{}
class SocialUpdatePostImageErrorState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}
class SocialGetPostsLoading extends SocialStates{}
class SocialGetPostsSuccess extends SocialStates{}
class SocialGetPostsError extends SocialStates{
  final error;
  SocialGetPostsError(this.error);
}

// Likes
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{}
// Comments
class SocialCommentPostSuccessState extends SocialStates{}
class SocialCommentPostErrorState extends SocialStates{}

// AllUsers
class SocialGetAllUsersLoadind  extends SocialStates{}
class SocialGetAllUsersSuccess  extends SocialStates{}
class SocialGetAllUsersError extends SocialStates{
  final error;
  SocialGetAllUsersError(this.error);
}
// Messages
class SocialGetMessageSuccessState extends SocialStates{}
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
// SignOut
class SocialSignOutSuccessState extends SocialStates{}
class SocialSignOutErrorState extends SocialStates{}
// IsDark
class ChangeMode extends SocialStates{}
