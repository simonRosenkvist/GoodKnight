package scene {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import asset.hudGFX;
	import asset.life2GFX;
	import asset.lifeGFX;
	import asset.pointsboardGFX;
	import asset.powerGFX;
	import player.Spelare;
	import player.Spelare2;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	public class HUD extends DisplayStateLayerSprite {
		private var m_skin:Sprite;
		private var num:int;
		private var m_player:Spelare;
		private var n_player:Spelare2;
		private var pointboard:pointsboardGFX;
		public var life:lifeGFX;
		public var life2:lifeGFX;
		public var life3:lifeGFX;
		public var life4:life2GFX;
		public var life5:life2GFX;
		public var life6:life2GFX;
		public var power:MovieClip;
		public var power2:MovieClip;
		private var six:Boolean = true;
		private var five:Boolean = true;
		private var four:Boolean = true;
		private var three:Boolean = true;
		private var two:Boolean = true;
		private var one:Boolean = true;
		
		public function HUD(nr, m_player, n_player) {
			super();
			this.num = nr;
			this.m_player = m_player;
			this.n_player = n_player;
		}
		
		override public function init():void{
			this.m_initSkin();
		}//End init
		
		private function m_initSkin():void {
			this.m_skin = new hudGFX;
			this.addChild(m_skin);
			this.life = new lifeGFX;
			life.scaleX = 0.5;
			life.scaleY = 0.5;
			life.x = -390;
			life.y = -10;
			m_skin.addChild(life);
			
			this.life2 = new lifeGFX;
			life2.scaleX = 0.5;
			life2.scaleY = 0.5;
			life2.x = -350;
			life2.y = -10;
			m_skin.addChild(life2);
			
			this.life3 = new lifeGFX;
			life3.scaleX = 0.5;
			life3.scaleY = 0.5;
			life3.x = -310;
			life3.y = -10;
			m_skin.addChild(life3);
			
			this.power = new powerGFX;
			this.power.x = -250;
			this.power.scaleX = 0.5;
			this.power.scaleY = 0.5;
			this.power.y = -5;
			this.power.gotoAndStop(m_player.killCount);
			m_skin.addChild(power);

			this.pointboard = new pointsboardGFX;
			m_skin.addChild(pointboard);
			
			if(num == 2) {
				
				this.power2 = new powerGFX;
				this.power2.x = 150;
				this.power2.scaleX = 0.5;
				this.power2.scaleY = 0.5;
				this.power2.y = -5;
				this.power2.gotoAndStop(n_player.killCount);
				m_skin.addChild(power2);
				
				this.life4 = new life2GFX;
				this.life4.x = 300;
				this.life4.y = -10;
				this.life4.scaleX = -0.5;
				this.life4.scaleY = 0.5;
				m_skin.addChild(life4);
				
				this.life5 = new life2GFX;
				this.life5.x = 340;
				this.life5.y = -10;
				this.life5.scaleX = -0.5;
				this.life5.scaleY = 0.5;
				m_skin.addChild(life5);
				
				this.life6 = new life2GFX;
				this.life6.x = 380;
				this.life6.y = -10;
				this.life6.scaleX = -0.5;
				this.life6.scaleY = 0.5;
				m_skin.addChild(life6);
			}
		}//End initSkin
		
		override public function update():void {
			checkHP();
			checkPower();
		}//End update
		
		private function checkHP():void {
			if(three == true && this.m_player.HP1 == 2) {three = false; this.m_skin.removeChild(life3);}
			if(two == true && this.m_player.HP1 == 1) {two = false; this.m_skin.removeChild(life2);}
			if(one == true && this.m_player.HP1 == 0) {one = false; this.m_skin.removeChild(life);}
			
			if (num == 2) {
			if(six == true && this.n_player.HP2 == 2) {six = false; this.m_skin.removeChild(life6);}
			if(five == true && this.n_player.HP2 == 1) {five = false; this.m_skin.removeChild(life5);}
			if(four == true && this.n_player.HP2 == 0) {four = false; this.m_skin.removeChild(life4);}
			}//End p2check
		}//End checkHP
		
		private function checkPower():void {
			this.power.gotoAndStop(m_player.killCount+1);
			if (num == 2) {
			this.power2.gotoAndStop(n_player.killCount);
			}//End p2check
		}//End checkPower
		
		override public function dispose():void {
			
		}
	}//End HUD
}//End package