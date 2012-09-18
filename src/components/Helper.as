package components {
	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.Batch;
	import com.facebook.graph.data.FacebookAuthResponse;
	import com.facebook.graph.net.FacebookBatchRequest;

	public class Helper {

		public static var applicationId:String = "254149237972904";
		public static var friendFields:int = 10;
		public static var friendsPerRequest:int = 5;

		public static var permissions:Array = ["user_about_me", "friends_about_me",
			"user_activities", "friends_activities", "user_education_history", "friends_education_history",
			"user_events", "friends_events", "user_groups", "friends_groups", "user_hometown",
			"friends_hometown", "user_interests", "friends_interests", "user_likes",
			"friends_likes", "user_location", "friends_location", "user_work_history",
			"friends_work_history"];

		public static function getBooks(userId:String):String {
			return getAttribute(userId, "books");
		}

		public static function getCurrentUser():String {
			return "/me";
		}

		public static function getData(id:String):String {
			return "/" + id;
		}

		public static function getEvents(userId:String):String {
			return getAttribute(userId, "events");
		}

		public static function getFacebookURL(id:String):String {
			return "http://www.facebook.com/" + id;
		}

		public static function getFriends():String {
			return "/me/friends";
		}

		public static function getFriendsInfo(friends:Array):Array {
			var batches:Array = new Array();
			var count:int = friends.length / friendsPerRequest;
			var remainder:int = friends.length % friendsPerRequest;
			var i:int, j:int, pos:int, batch:Batch;
			for (i = 0; i < count; i++) {
				pos = i * friendsPerRequest;
				batch = new Batch();
				for (j = 0; j < friendsPerRequest; j++) {
					getPersonInfo(batch, friends[pos + j]);
				}
				batches.push(batch);
			}
			if (remainder > 0) {
				batch = new Batch();
				pos = count * friendsPerRequest;
				for (i = 0; i < remainder; i++) {
					getPersonInfo(batch, friends[pos + i]);
				}
				batches.push(batch);
			}
			return batches;
		}

		public static function getGroups(userId:String):String {
			return getAttribute(userId, "groups");
		}

		public static function getInterests(userId:String):String {
			return getAttribute(userId, "interests");
		}

		public static function getLikes(userId:String):String {
			return getAttribute(userId, "likes");
		}

		public static function getMovies(userId:String):String {
			return getAttribute(userId, "movies");
		}

		public static function getMusic(userId:String):String {
			return getAttribute(userId, "music");
		}

		public static function getMutualFriends(userId:String):String {
			return "/me/mutualfriends?user=" + userId;
		}

		public static function getPersonInfo(batch:Batch, userId:String):void {
			batch.add(getUser(userId));
			batch.add(getMutualFriends(userId));
			batch.add(getBooks(userId));
			batch.add(getEvents(userId));
			batch.add(getGroups(userId));
			batch.add(getInterests(userId));
			batch.add(getLikes(userId));
			batch.add(getMovies(userId));
			batch.add(getMusic(userId));
			batch.add(getTelevision(userId));
		}

		public static function getSearch(term:String):Batch {
			var batch:Batch = new Batch();
			batch.add(getSearchPeople(term));
			batch.add(getSearchEvents(term));
			batch.add(getSearchGroups(term));
			batch.add(getSearchPages(term));
			return batch;
		}

		public static function getSearchEvents(term:String):String {
			return "/search?type=event&q=" + term;
		}

		public static function getSearchGroups(term:String):String {
			return "/search?type=group&q=" + term;
		}

		public static function getSearchPages(term:String):String {
			return "/search?type=page&q=" + term;
		}

		public static function getSearchPeople(term:String):String {
			return "/search?type=user&q=" + term;
		}

		public static function getTelevision(userId:String):String {
			return getAttribute(userId, "television");
		}

		public static function getUser(userId:String):String {
			return getData(userId);
		}

		private static function getAttribute(userId:String, attribute:String):String {
			return "/" + userId + "/" + attribute;
		}
	}
}
