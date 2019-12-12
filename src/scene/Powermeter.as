package scene {
	
	import flash.display.MovieClip;
	import asset.powerGFX;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class Powermeter extends DisplayStateLayerSprite {
		public var m_skin:MovieClip;
		
		public function Powermeter() {
			super();
		}
		override public function init():void {
			initSkin();
		}
		
		private function initSkin():void {
			this.m_skin = new powerGFX;
			this.addChild(m_skin);
		}
	}
}