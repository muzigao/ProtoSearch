package components {
	import flash.utils.Dictionary;

	[RemoteClass(alias = "com.components.UserData")]
	public class UserData {

		public function UserData() {
			friends = new Dictionary();
			mutualFriends = new Dictionary();
			myGroups = new Dictionary();
			friendGroups = new Dictionary();
		}

		public var data:Object;
		public var friendGroups:Dictionary;
		public var friends:Dictionary;
		public var mutualFriends:Dictionary;
		public var myGroups:Dictionary;
	}
}
