package player {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import asset.batmonsterGFX;
	import scene.MonsterHandler;
	import scene.Spit;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Batmonster extends DisplayStateLayerSprite {
		
		public var m_skin:MovieClip;
		private var players:Spelare;
		private var players2:Spelare2;
		private var layer:DisplayStateLayer;
		private var t:Boolean = false;
		public var eHitBox:Sprite;
		private var monsterHandler:MonsterHandler;
		private var rnd:int;
		private var playerList:Vector.<DisplayStateLayerSprite> = new Vector.<DisplayStateLayerSprite>;
		public var target:DisplayStateLayerSprite;
		public var spit:Spit;
		private var vel:int;
		private var a:Boolean = true;
		public var HP:int;
		public var inv:Boolean;
		private var flick:Flicker;
		private var batmonsterdeath:SoundObject;//death sound
		public var score:int;
		
		public function Batmonster(m_player:Spelare, n_player:Spelare2, n_layer:DisplayStateLayer, 
								   monsterHandler:MonsterHandler, num:int) {
			
			super();
			this.players = m_player;
			this.players2 = n_player;
			this.layer = n_layer;
			this.monsterHandler = monsterHandler;
			this.rnd = num;
			this.HP = 2;
			this.score = score;
		}
		
		override public function init():void {
			this.m_initSkin();
			if(rnd == 2) {
				playerList.push(players);
				playerList.push(players2);
				this.target = playerList[Math.round(Math.random()*1)];
			}
			else {this.target = players}
			
		}//End init
		
		override public function update():void {
			checkAtk();
			checkHit();
				if (rnd ==2 ) {
					checkTarget();
					}
		}//End update
		
		override public function dispose():void {
			this.removeChild(m_skin);
			this.m_skin = null;
		}
		
		private function m_initSkin():void {
			this.m_skin = new batmonsterGFX;
			this.addChild(this.m_skin);
			this.eHitBox = new Sprite();
			//this.eHitBox.graphics.beginFill(0x0000FF);
			this.eHitBox.graphics.drawRect(-35, -25, 15, 45);
			this.eHitBox.rotationZ = -38;
			this.m_skin.addChild(eHitBox);
			this.m_skin.gotoAndStop('batmonster_fly');
		}
		
		private function checkTarget():void {
			if (this.target == players) {
				if (players.HP1 < 1) {
				this.target = players2;
				}//End HP check player 1
			}//End target check player 1
			
			if (this.target == players2) {
				if (players2.HP2 < 1) {
					this.target = players;
				}//End HP check player 2
			}//End target check player2
		}//End checkTarget
		
		private function move():void {
	
			if(this.m_skin.currentFrameLabel != 'batmonster_death') {
				this.m_skin.gotoAndStop('batmonster_fly');
			}//End animation Check
			
		}//End move
		
		private function checkHit():void {
			if(this.eHitBox.hitTestObject(players.dmgBox) && players.attacking == true && inv == false) {
				this.HP -= 1+ players.power + players.combo;
				inv = true;
					flick = new Flicker(this.m_skin, 200, 60, true);
					Session.effects.add(flick);
					Session.timer.create(500, resetInv);
						if(this.HP < 1 && this.m_skin.currentFrameLabel != 'batmonster_death') {
							players.score += 15;
							
							Session.sound.soundChannel.sources.add('batmonsterdeath', GoodKnight.BATMONSTER_DEATH_SOUND);
								this.batmonsterdeath = Session.sound.soundChannel.get("batmonsterdeath");
								this.batmonsterdeath.volume = 0.2;
								this.batmonsterdeath.play();
							
							this.m_skin.gotoAndStop('batmonster_death');
							Session.timer.create(1000, die);
								players.killCount ++;
						}//End death
			}//End if
			
			if (players2) {
			if(this.eHitBox.hitTestObject(players2.dmgBox) && players2.attacking == true && inv == false) {
				this.HP -= 1+ players2.power + players2.combo;
				inv = true;
					flick = new Flicker(this.m_skin, 200, 60, true);
					Session.effects.add(flick);
					Session.timer.create(500, resetInv);
						if(this.HP < 1 && this.m_skin.currentFrameLabel != 'batmonster_death') {
							
							players2.score += 15;
							
							this.m_skin.gotoAndStop('batmonster_death');
							Session.timer.create(1000, die);
								players2.killCount ++;
						}//End death
			}//End if
		}//End p2check
		}//End checkHit
		
		private function die():void {
			this.monsterHandler.removeBat(this);
		}//End die
		
		private function checkAtk():void {
	
			if (this.target.x + 120 > this.x && this.target.x - 120 < this.x && this.target.y > this.y &&
				this.m_skin.currentFrameLabel != 'batmonster_death') {
				if (a==true){batAtk();}
				a=false;
			}//End if
		}//End checkAtk
		
		private function batAtk():void {
			
			this.spit = new Spit();
			this.spit.scaleY = 0.5;
			this.spit.scaleX = 0.5;
				if (this.scaleX > 0) {
					this.spit.x = this.x -45;
					this.spit.y = this.y -0;
					this.layer.addChild(this.spit);
						Session.timer.create(1000, resetAtk);
						
			}//End if front attack
				
			else if (this.scaleX < 0) {
				this.spit.scaleX = -0.5;
				this.spit.x = this.x +45;
				this.spit.y = this.y -0;
				this.layer.addChild(this.spit);
				Session.timer.create(1000, resetAtk);
			}//End else back attack
				
			//HIT CHECK
		}//End batAtk
		
		private function resetAtk():void {
			this.spit.removeSpit();
			this.layer.removeChild(spit);
			this.spit = null;
			a = true;
		}//End resetAtk
		
		private function resetInv():void {
			this.inv = false;
			if(this.m_skin.currentFrameLabel == 'batmonster_still') {
				this.m_skin.gotoAndStop('batmonster_fly');
			}
		}//End reset inv
	}
}