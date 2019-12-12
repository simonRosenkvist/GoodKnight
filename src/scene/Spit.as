package scene {
	
	import flash.display.MovieClip;
	import asset.spitGFX;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class Spit extends DisplayStateLayerSprite {
		private var m_skin:MovieClip;
		
		public function Spit() {
			this.initSkin();
			super();
		}
		private function initSkin():void {
			this.m_skin = new spitGFX;
			this.m_skin.scaleX = 0.5;
			this.m_skin.scaleY = 0.5;
			this.addChild(m_skin);
		}//End initSkin
		
		override public function dispose():void {
			this.removeChild(m_skin);
			this.m_skin = null;
		}
		
		public function removeSpit():void {
			this.removeChild(m_skin);
		}//end removeSpit
	}
}

