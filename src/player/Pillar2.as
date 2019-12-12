package player {
	
	import flash.display.MovieClip;
	import asset.pillar2GFX;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;

	public class Pillar2 extends DisplayStateLayerSprite {
		private var m_skin:MovieClip;
		
		public function Pillar2() {
			
			super();
		}
		override public function init():void {
			this.m_skin = new pillar2GFX();
			this.addChild(m_skin);
		}//End init
		
		override public function dispose():void {
			this.removeChild(m_skin);
			this.m_skin = null;
		}//End dispose
	}
}