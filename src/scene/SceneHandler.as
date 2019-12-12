package scene {
	import flash.display.MovieClip;
	
	import asset.background1GFX;
	
	import player.Pillar2;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
	public class SceneHandler {
		private var m_layer:DisplayStateLayer;
		private var n_layer:DisplayStateLayer;
		private var f_layer:DisplayStateLayer;
		private var pillar:Pillar;
		private var pillar2:Pillar2;
		private var background:MovieClip;
		private var window:Window;
		
		public function SceneHandler(m_layer:DisplayStateLayer, n_layer:DisplayStateLayer, f_layer:DisplayStateLayer) {
			this.m_layer = m_layer;
			this.n_layer = n_layer;
			this.f_layer = f_layer;
		}
		
		public function initScene():void {
				pillar = new Pillar; // down left
				pillar.scaleX = 0.5;
				pillar.scaleY = 0.5;
				pillar.x = 200;
				pillar.y = 412;
				f_layer.addChild(pillar);
				
				pillar = new Pillar; // down left 2
				pillar.scaleX = 0.5;
				pillar.scaleY = 0.5;
				pillar.x = -30;
				pillar.y = 412;
				f_layer.addChild(pillar);
				
				pillar = new Pillar; // up left
				pillar.scaleX = 0.5;
				pillar.scaleY = 0.5;
				pillar.x = 200;
				pillar.y = 222;
				f_layer.addChild(pillar);
				
				pillar = new Pillar; // up left 2
				pillar.scaleX = 0.5;
				pillar.scaleY = 0.5;
				pillar.x = -30;
				pillar.y = 222;
				f_layer.addChild(pillar);
				
				pillar2 = new Pillar2; // up left 3
				pillar2.scaleX = 0.4;
				pillar2.scaleY = 0.5;
				pillar2.x = -20;
				pillar2.y = 15;
				f_layer.addChild(pillar2);
				
				pillar = new Pillar; // up right
				pillar.scaleX = 0.5;
				pillar.scaleY = 0.5;
				pillar.x = 570;
				pillar.y = 222;
				f_layer.addChild(pillar);
				
				pillar = new Pillar; // up right 2 
				pillar.scaleX = 0.5;
				pillar.scaleY = 0.5;
				pillar.x = 770;
				pillar.y = 222;
				f_layer.addChild(pillar);
				
				pillar2 = new Pillar2();
				pillar2.scaleX = -0.4;
				pillar2.scaleY = 0.5;
				pillar2.x = 812;
				pillar2.y = 15;
				f_layer.addChild(pillar2);
				
				pillar = new Pillar; // down right
				pillar.scaleX = -0.5;
				pillar.scaleY = 0.5;
				pillar.x = 625;
				pillar.y = 412;
				f_layer.addChild(pillar);
				
				pillar = new Pillar; // down right 2
				pillar.scaleX = 0.5;
				pillar.scaleY = 0.5;
				pillar.x = 770;
				pillar.y = 412;
				f_layer.addChild(pillar);
				
				background = new background1GFX;
				background.x = 400;
				background.y = 300;
				this.m_layer.addChild(background);
				
				window = new Window();
				window.x = 365;
				window.y = 100;
				this.m_layer.addChild(window);
		}//End init
	}
}