package scene {
	
	import flash.display.MovieClip;
	import asset.window1GFX;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class Window extends DisplayStateLayerSprite {
		public var m_skin:MovieClip;
		
		public function Window() {
			super();
			
		}
		
		override public function init():void{
			this.m_initSkin();
		}//End init
		
		override public function dispose():void {
			
		}
		
		private function m_initSkin():void {
			this.m_skin = new window1GFX;
			this.addChild(m_skin);
		}//End initSkin
	}//End pillar
}//End package