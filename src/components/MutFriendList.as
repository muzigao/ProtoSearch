// ActionScript file
package components {
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

	public class MutFriendList extends Sprite {

		//picURL: array of profile pictures of mutral friends
		//tooltipInfo: array of text displayed in tooltip of mutual friend
		public function MutFriendList(picURL:Array, tooltipInfo:Array) {
			this.drawContainer();

			//load picture
			//i< number of mutual friends
			for (var i:Number = 0; i < picURL.length; i++) {
				mutFriend[i] = new MutFriendItem(picURL[i], tooltipInfo[i]);
				mutFriend[i].x = 10 + i * 50;
				mutFriend[i].y = 0;
				mutFriendBg.addChild(mutFriend[i]);

				if (this.isMutFriendItemVisible(mutFriend[i].x))
					mutFriend[i].visible = true;
				else
					mutFriend[i].visible = false;
			}
			this.drawNavigator();
		}

		public var bgHeight:Number = 50;

		public var bgWidth:Number = 170;
		private var leftNav:Sprite = new Sprite();

		private var mutFriend:Array = new Array(); //array of mutural friends items
		private var mutFriendBg:Sprite = new Sprite();

		private var picSize:Number = 30;
		private var rightNav:Sprite = new Sprite();

		protected function drawContainer():void {
			//draw container
			mutFriendBg.graphics.beginFill(0xffffff, 1);
			mutFriendBg.graphics.drawRoundRect(0, 0, bgWidth, bgHeight, 5, 5);

			mutFriendBg.graphics.moveTo(bgWidth / 2 - 8, 0);
			mutFriendBg.graphics.lineTo(bgWidth / 2, -6);
			mutFriendBg.graphics.lineTo(bgWidth / 2 + 8, 0);

			mutFriendBg.graphics.endFill();

			//draw filter
			var conFilter:BitmapFilter;
			conFilter = new DropShadowFilter(1, 90, 0xBAB2B1, 1.0, 2, 2, 1, 15);
			mutFriendBg.filters = [conFilter];

			this.addChild(mutFriendBg);
		}

		protected function drawNavigator():void {
			//left navigator
			leftNav.graphics.beginFill(0xffffff, 1);
			leftNav.graphics.drawRect(0, 0, 10, bgHeight);
			leftNav.graphics.endFill();

			leftNav.graphics.beginFill(0x45272F, 1);
			leftNav.graphics.moveTo(10, bgHeight / 2 - 8);
			leftNav.graphics.lineTo(6, bgHeight / 2);
			leftNav.graphics.lineTo(10, bgHeight / 2 + 8);
			leftNav.graphics.endFill();
			leftNav.buttonMode = true;
			leftNav.addEventListener(MouseEvent.CLICK, leftNav_Click);
			mutFriendBg.addChild(leftNav);

			//right navigator
			rightNav.graphics.beginFill(0xffffff, 1);
			rightNav.graphics.drawRect(bgWidth - 10, 0, 10, bgHeight);
			rightNav.graphics.endFill();

			rightNav.graphics.beginFill(0x45272F, 1);
			rightNav.graphics.moveTo(bgWidth - 10, bgHeight / 2 - 8);
			rightNav.graphics.lineTo(bgWidth - 6, bgHeight / 2);
			rightNav.graphics.lineTo(bgWidth - 10, bgHeight / 2 + 8);
			rightNav.graphics.endFill();
			rightNav.buttonMode = true;
			rightNav.addEventListener(MouseEvent.CLICK, rightNav_Click);
			mutFriendBg.addChild(rightNav);
		}

		//each time three mutual friends will be displayed on the list
		protected function isMutFriendItemVisible(positionX:Number):Boolean {
			if (positionX >= 160 || positionX < 10)
				return false;
			else
				return true;
		}


		protected function leftNav_Click(event:MouseEvent):void {
			if (mutFriend[0].x < 10) {
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
			if (mutFriend[mutFriend.length - 1].x > 10) {
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
