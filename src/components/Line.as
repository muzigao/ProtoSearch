// ActionScript file
package components {
	import flash.display.Sprite;

	public class Line extends Sprite {

		public function Line(startX:Number, startY:Number, endX:Number, endY:Number,
			type:ResultType) {
			this.lineColor = this.getColorByType(type);
			this.graphics.lineStyle(lineThick, lineColor, 0.3);
			this.graphics.moveTo(startX, startY);
			this.graphics.lineTo(endX, endY);
		}

		private var lineColor:Number; //color of line
		private var lineThick:Number = 2; //thickness of line

		protected function getColorByType(resultType:ResultType):Number {
			var color:Number;
			switch (resultType) {
				case ResultType.PERSON:
					color = 0x5B9AB6; //PERSON
					break;
				case ResultType.EVENT:
					color = 0xCADAE1; //GROUP
					break;
				case ResultType.GROUP:
					color = 0xEAC4C4; //EVENT
					break;
				case ResultType.PAGE:
					color = 0xC44747; //PAGE
					break;

			}
			return color;
		}
	}
}
