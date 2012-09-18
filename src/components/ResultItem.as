package components {
	import components.ResultType;

	public class ResultItem {

		public function ResultItem(name:String, type:ResultType, url:String, imageURL:String,
			score:int) {
			_name = name;
			_type = type;
			_url = url;
			_imageURL = imageURL;
			_score = score;
		}

		private var _imageURL:String;
		private var _name:String;
		private var _score:int;
		private var _type:ResultType = new ResultType();
		private var _url:String;

		public function get imageURL():String {
			return _imageURL;
		}

		public function get name():String {
			return _name;
		}

		public function get score():String {
			return _imageURL;
		}

		public function get type():ResultType {
			return _type;
		}

		public function get url():String {
			return _url;
		}
	}
}
