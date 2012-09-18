// ActionScript file
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
	import mx.messaging.channels.StreamingAMFChannel;
	import spark.skins.spark.StackedFormHeadingSkin;

	public class MutualList extends Sprite {

		//picURL: array of profile pictures of mutral friends
		//tooltipInfo: array of text displayed in tooltip of mutual friend
		public function MutualList(resultList:Array, tthHelper:TerrificTabHelper) {
			this.drawContainer();

			//isMoreTool=isMore;

			//load picture
			//i< number of mutual friends
			for (var i:Number = 0; i < resultList.length; i++) {
				mutFriend[i] = new MutualItem(resultList[i], tthHelper);
				mutFriend[i].x = -bgWidth / 2 + 10 + i * 50;
				mutFriend[i].y = -bgHeight / 2;
				mutualBg.addChild(mutFriend[i]);

				if (this.isMutFriendItemVisible(mutFriend[i].x))
					mutFriend[i].visible = true;
				else
					mutFriend[i].visible = false;
			}
			this.drawNavigator();
		}

		public var bgHeight:Number = 50;

		public var bgWidth:Number = 120;

		private var isMoreTool:Boolean;
		private var leftNav:Sprite = new Sprite();

		private var mutFriend:Array = new Array(); //array of mutural friends items
		private var mutualBg:Sprite = new Sprite();

		private var picSize:Number = 30;
		private var rightNav:Sprite = new Sprite();

		protected function drawContainer():void {
			//draw container
			mutualBg.graphics.beginFill(0xffffff, 1);
			mutualBg.graphics.drawRoundRect(x - bgWidth / 2, y - bgHeight / 2, bgWidth,
				bgHeight, 5, 5);

			/*
			if(isMoreTool)
			{
				mutualBg.graphics.moveTo(bgWidth/2-8, 0);
				mutualBg.graphics.lineTo(bgWidth/2, -6);
				mutualBg.graphics.lineTo(bgWidth/2+8, 0);
			}
			*/
			mutualBg.graphics.endFill();

			//draw filter
			var conFilter:BitmapFilter;
			conFilter = new DropShadowFilter(2, 90, 0xBAB2B1, 1.0, 3, 3, 1, 15);
			mutualBg.filters = [conFilter];

			this.addChild(mutualBg);
		}

		protected function drawNavigator():void {
			//left navigator
			leftNav.graphics.beginFill(0xffffff, 1);
			leftNav.graphics.drawRect(x - bgWidth / 2, y - bgHeight / 2, 10, bgHeight);
			leftNav.graphics.endFill();

			leftNav.graphics.beginFill(0x45272F, 1);
			leftNav.graphics.moveTo(x - bgWidth / 2 + 10, y - 8);
			leftNav.graphics.lineTo(x - bgWidth / 2 + 6, y);
			leftNav.graphics.lineTo(x - bgWidth / 2 + 10, y + 8);
			leftNav.graphics.endFill();
			leftNav.buttonMode = true;
			leftNav.addEventListener(MouseEvent.CLICK, leftNav_Click);
			mutualBg.addChild(leftNav);

			//right navigator
			rightNav.graphics.beginFill(0xffffff, 1);
			rightNav.graphics.drawRect(x + bgWidth / 2 - 10, y - bgHeight / 2, 10,
				bgHeight);
			rightNav.graphics.endFill();

			rightNav.graphics.beginFill(0x45272F, 1);
			rightNav.graphics.moveTo(x + bgWidth / 2 - 10, y - 8);
			rightNav.graphics.lineTo(x + bgWidth / 2 - 6, y);
			rightNav.graphics.lineTo(x + bgWidth / 2 - 10, y + 8);
			rightNav.graphics.endFill();
			rightNav.buttonMode = true;
			rightNav.addEventListener(MouseEvent.CLICK, rightNav_Click);
			mutualBg.addChild(rightNav);
		}

		//each time three mutual friends will be displayed on the list
		protected function isMutFriendItemVisible(positionX:Number):Boolean {
			if (positionX >= (-bgWidth / 2 + 10 + 2 * bgHeight) || positionX < (-bgWidth /
				2 + 10))
				return false;
			else
				return true;
		}


		protected function leftNav_Click(event:MouseEvent):void {
			if (mutFriend[0].x < (-bgWidth / 2 + 10)) {
				for (var i:Number = 0; i < mutFriend.length; i++) {
					mutFriend[i].x += 50;
					if (this.isMutFriendItemVisible(mutFriend[i].x))
						mutFriend[i].visible = true;
					else
						mutFriend[i].visible = false;
				}
			}
		}


		protected function rightNav_Click(event:MouseEvent):void {
			if (mutFriend[mutFriend.length - 1].x > (-bgWidth / 2 + 10)) {
				for (var i:Number = 0; i < mutFriend.length; i++) {
					mutFriend[i].x -= 50;
					if (this.isMutFriendItemVisible(mutFriend[i].x))
						mutFriend[i].visible = true;
					else
						mutFriend[i].visible = false;
				}
			}
		}
	}
}
