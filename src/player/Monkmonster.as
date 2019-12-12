package player {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import asset.monkmonsterGFX;
	
	import scene.MonsterHandler;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Monkmonster extends DisplayStateLayerSprite {
		public var m_skin:MovieClip;
		private var players:Spelare;
		private var players2:Spelare2;
		private var layer:DisplayStateLayer;
		private var monsterHandler:MonsterHandler;
		private var u:Boolean = false;
		public var inv:Boolean = false;
		public var eHitbox:Sprite;
		public var atkBox:Sprite;
		public var walk:Boolean;
		private var rnd:int;
		private var playerList:Vector.<DisplayStateLayerSprite> = new Vector.<DisplayStateLayerSprite>;
		public var target:DisplayStateLayerSprite;
		public var HP:int;
		private var flick:Flicker;
		private var monkmonsterdeath:SoundObject;//death sound
		private var monkmonsterslime:SoundObject;//death sound
		
		public function Monkmonster(m_player:Spelare, n_player:Spelare2, n_layer:DisplayStateLayer, 
									monsterHandler:MonsterHandler, nr:int) {
			this.players = m_player;
			this.players2 = n_player;
			this.layer = n_layer;
			this.monsterHandler = monsterHandler;
			this.rnd = nr;
			this.HP = 3;
			super();
		}
		override public function init():void {
			m_initSkin();
				if(rnd == 2) {
					playerList.push(players);
					playerList.push(players2);
					this.target = playerList[Math.round(Math.random()*1)];
					}
				else {this.target = this.players}
						this.m_skin.gotoAndStop('monkmonster_walk');
		}//End init
		
		override public function update():void {
			checkHit();
			checkAtk();
			if (rnd == 2){
			targetCheck();}
		}//End update
		
		override public function dispose():void {
		this.removeChild(m_skin);
		this.m_skin = null;
		}//End dispose
		
		private function targetCheck():void {
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
		}//End targetCheck
		
		private function checkHit():void {
			if(players.dmgBox.hitTestObject(this.eHitbox) && players.attacking == true && inv == false) {
				inv = true;
				HP -= 1+players.power+players.combo;
				flick = new Flicker (this.m_skin, 200, 60, true);
				Session.effects.add(flick);
				Session.timer.create(200, resetInv);
				if (HP < 1) {					
					
					players.score += 10;
					
					Session.sound.soundChannel.sources.add('monkmonsterdeath', GoodKnight.MONKMONSTER_DEATH_SOUND);
						this.monkmonsterdeath = Session.sound.soundChannel.get("monkmonsterdeath");
						this.monkmonsterdeath.volume = 0.2;
						this.monkmonsterdeath.play();
					
							players.killCount ++;
								if (this.m_skin.currentFrameLabel != 'monkmonster_death') {
									this.m_skin.gotoAndStop('monkmonster_death');
									this.m_skin.removeChild(eHitbox);
										Session.timer.create(700, die);
										
											if(this.m_skin.atkBox) {
												this.m_skin.removeChild(atkBox);
						}//End if atkBox check
					}//End if attackbox remove
				}//End HP check
			}//End if
			
			if(players2) {
			if(players2.dmgBox.hitTestObject(this.eHitbox) && players2.attacking == true && inv == false) {
				inv = true;
				HP -= 1+players2.power+players2.combo;
				flick = new Flicker (this.m_skin, 200, 60, true);
				Session.effects.add(flick);
				Session.timer.create(200, resetInv);
				if (HP < 1 && this.m_skin.currentFrameLabel != 'monkmonster_death') {
					
					players2.score += 10;
					
					Session.sound.soundChannel.sources.add('monkmonsterdeath', GoodKnight.MONKMONSTER_DEATH_SOUND);
						this.monkmonsterdeath = Session.sound.soundChannel.get("monkmonsterdeath");
						this.monkmonsterdeath.volume = 0.2;
						this.monkmonsterdeath.play();
						
					Session.sound.soundChannel.sources.add('monkmonsterslime', GoodKnight.MONKMONSTER_SLIME_SOUND);
						this.monkmonsterslime = Session.sound.soundChannel.get("monkmonsterslime");
						this.monkmonsterslime.volume = 0.2;
						this.monkmonsterslime.play();
						
					
							players2.killCount ++;
								this.m_skin.gotoAndStop('monkmonster_death');
								this.m_skin.removeChild(eHitbox);
									Session.timer.create(700, die);
									
										if(this.m_skin.atkBox) {
											this.m_skin.removeChild(atkBox);
						}//End if attackbox remove
					}//End HP check
				}//End hit test		
			}//End p2 check
		}//End checkHit
		
		private function m_initSkin():void {
			this.m_skin = new monkmonsterGFX;
			this.eHitbox = new Sprite();
			//this.eHitbox.graphics.beginFill(0x0000FF);
			this.eHitbox.graphics.drawRect(90, -175, 155, 425);
			this.m_skin.addChild(eHitbox);
			this.addChild(m_skin);
		}//End initSkin
		
		private function die():void {
			this.monsterHandler.removeCultist(this);
		}//End die
		
		private function checkAtk():void {
			if(this.x < this.target.x + 50 || this.x > this.target.x - 50 && this.players.y+10 == this.y) { // REDO DEATH IS NOT PERMANENT ENOUGH
				//if(this.players.y-10 == this.y){
					atk();
				//} //End if X
			}//End if Y
		}//End checkAtk
		
		private function atk():void {
			if (this.m_skin.currentFrameLabel != 'monkmonster_death' && u == false && this.m_skin.currentFrameLabel != 'monkmonster_still') {
				u = true;
				walk = false;
				this.m_skin.gotoAndStop('monkmonster_attack');
				Session.timer.create(800, makeBox);
				Session.timer.create(1200, resetAtk);
		}//End if
	}//End atk
		
		private function makeBox():void {
			this.atkBox = new Sprite;
			//this.atkBox.graphics.beginFill(0xFF0000);
			this.atkBox.graphics.drawRect(-200,-170,400,150);
			this.m_skin.addChild(atkBox);
		}//End makeBox
		
		private function resetAtk():void {
	if (atkBox && u==true) {
		this.m_skin.removeChild(atkBox);
		walk = true;
		
			if(this.m_skin.currentFrameLabel != 'monkmonster_death') {
				this.m_skin.gotoAndStop('monkmonster_walk');
			}//death check
			
		Session.timer.create(1500, function():void {u=false});
	}//End if
		}//End resetAtk
		
		private function resetInv():void {
			this.inv = false;
			if (this.m_skin.currentFrameLabel == 'monkmonster_still') {
			this.m_skin.gotoAndStop('monkmonster_walk');}
		}//End resetInv
	}
}