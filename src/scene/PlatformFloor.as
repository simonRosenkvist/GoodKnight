package scene {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import asset.platform1GFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class PlatformFloor extends DisplayStateLayerSprite {
		
		private var m_Platform:MovieClip;
		public var box:Sprite;
		
		public function PlatformFloor() {
			super();
		}
		override public function init():void {
			this.m_initPlatformL();
		}//End init
		
		public function m_initPlatformL():void {
			this.m_Platform = new platform1GFX();
			
			this.box = new Sprite();
			this.box.graphics.beginFill(0x0F0);
			this.box.graphics.drawRect(0, -12, 800, 10);
			this.box.graphics.endFill();
			m_Platform.addChild(box);
			
			this.addChild(this.m_Platform);
		}//End m_initPlatform
	}
}