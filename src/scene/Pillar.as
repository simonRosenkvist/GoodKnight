package scene {
	
	import flash.display.Sprite;
	
	import asset.pillar1GFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class Pillar extends DisplayStateLayerSprite {
		public var m_skin:Sprite;
		
		public function Pillar() {
			super();
			
		}
		
		override public function init():void{
			this.m_initSkin();
		}//End init
		
		private function m_initSkin():void {
			this.m_skin = new pillar1GFX;
			this.addChild(m_skin);
		}//End initSkin
		
		override public function dispose():void {
			this.removeChild(m_skin);
			this.m_skin = null;
		}//End dispose
	}//End pillar
}//End package