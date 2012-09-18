package components {
	import components.ResultItem;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import mx.controls.Alert;

	public class ConnectionMoreItem extends Sprite {

		public function ConnectionMoreItem(mulList:Array, positionType:Number, tthHelper:TerrificTabHelper) {
			this._tthHelper = tthHelper;
			//add container
			this.drawContainer();


			//add more number
			numStr = mulList.length.toString();
			this.drawNum();

			//add more list
			this.moreList = mulList;
			this.position = positionType;
			this.addMoreList();
			this.drawCover();

		}

		private var _tthHelper:TerrificTabHelper;
		private var bgHeight:Number = 50;
		private var bgWidth:Number = 50;
		private var color:Number;
		private var connectionItem:Sprite = new Sprite();
		private var cover:Sprite = new Sprite();

		private var isShow:Boolean = false;

		private var load:Loader = new Loader();

		private var moreList:Array;
		private var moreTF:TextField;
		private var mutualList:MutualList;
		private var numStr:String;

		private var numTF:TextField;
		private var picSize:Number = 40;
		private var position:Number;
		private var profileImg:Bitmap;

		protected function addMoreList():void {
			mutualList = new MutualList(moreList, _tthHelper);
			switch (position) {
				case 0:
					mutualList.x = bgWidth + 50;
					mutualList.y = 0;
					break;
				case 1:
					mutualList.x = 0;
					mutualList.y = mutualList.height + 20;
					break;
				case 2:
					mutualList.x = bgWidth + 50;
					mutualList.y = 0;
					break;
				case 3:
					mutualList.x = 0;
					mutualList.y = -mutualList.height - 20;
					break;
				case 4:
					mutualList.x = -bgWidth - 50;
					mutualList.y = 0;
					break;
				case 5:
					mutualList.x = -bgWidth - 50;
					mutualList.y = 0;
					break;
			}
			this.addChild(mutualList);
			mutualList.visible = false;
		}

		protected function drawContainer():void {
			//draw container
			connectionItem.graphics.beginFill(0xffffff, 1);
			connectionItem.graphics.drawRoundRect(x - bgWidth / 2, y - bgHeight /
				2, bgWidth, bgHeight, 5, 5);
			connectionItem.graphics.endFill();

			//draw filter
			var bgFilter:BitmapFilter;
			bgFilter = new DropShadowFilter(2, 90, 0x4a4a4a, 1.0, 3, 3, 1, 15);
			connectionItem.filters = [bgFilter];

			this.addChild(connectionItem);
		}

		protected function drawCover():void {
			cover.graphics.beginFill(0xffffff, 0);
			cover.graphics.drawRoundRect(x - bgWidth / 2, y - bgHeight / 2, bgWidth,
				bgHeight, 5, 5);
			cover.graphics.endFill();
			cover.buttonMode = true;

			cover.addEventListener(MouseEvent.CLICK, isShowMoreList);
			this.addChild(cover);
		}

		protected function drawNum():void {
			numTF = new TextField();
			numTF.text = numStr;
			var ratio1:Number;

			ratio1 = (bgWidth - 5) / numTF.textWidth;
			if (ratio1 >= 2)
				ratio1 = 2;
			numTF.scaleX = ratio1;
			numTF.scaleY = ratio1;

			numTF.x = -numTF.textWidth;
			numTF.y = -bgHeight / 2;

			this.addChild(numTF);

			moreTF = new TextField();
			moreTF.text = "more";

			/*
			var ratio2:Number;

			ratio2=(bgWidth-5)/moreTF.textWidth;
			moreTF.scaleX=ratio2;
			moreTF.scaleY=ratio2;
			*/

			moreTF.x = -moreTF.textWidth / 2;
			moreTF.y = 0;
			this.addChild(moreTF);
		}

		protected function isShowMoreList(event:Event):void {
			//Alert.show(position.toString());
			if (isShow == false) {
				mutualList.visible = true;
				isShow = true;
			} else {
				mutualList.visible = false;
				isShow = false;
			}


		}
	}
}
