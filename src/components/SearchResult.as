// ActionScript file
package components {
	import components.ResultItem;

	public class SearchResult {

		public function SearchResult(result:ResultItem, initialScore:int) {
			_initialScore = initialScore;
			_result = result;
			_mutualFriends = new Array();
			_connections = new Array();
		}

		private var _connections:Array; // array of result items

		private var _initialScore:int;
		private var _mutualFriends:Array; // array of result items
		private var _result:ResultItem;

		public function addConnection(connection:ResultItem):void {
			_connections.push(connection);
		}

		public function addMutualFriend(friend:ResultItem):void {
			_mutualFriends.push(friend);
		}

		public function get connections():Array {
			return _connections;
		}

		public function get mutualFriends():Array {
			return _mutualFriends;
		}

		public function get result():ResultItem {
			return _result;
		}

		public function get score():int {
			return (_initialScore + (10 * mutualFriends.length) + (7 * connections.
				length));
		}
	}
}
