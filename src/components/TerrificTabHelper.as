package components {
	import mx.containers.ViewStack;
	import mx.controls.Alert;
	import spark.components.NavigatorContent;

	public class TerrificTabHelper {

		private static const MAXTABS:int = 10;

		public function TerrificTabHelper(vsContainer:ViewStack) {
			_vsContainer = vsContainer;
		}

		private var _vsContainer:ViewStack;

		public function addTab(name:String, url:String):void {
			if (_vsContainer.getChildren().length <= MAXTABS) {
				var ncTab:NavigatorContent = new NavigatorContent();
				var btTab:BrowserTab = new BrowserTab();
				btTab.setURL(url);
				ncTab.addElement(btTab);
				ncTab.label = name;
				_vsContainer.addElement(ncTab);
			} else {
				Alert.show("Sorry, you cannot open more than " + MAXTABS + " tabs, please close one to open another!");
			}
		}
	}
}
