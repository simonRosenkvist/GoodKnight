package player {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import asset.knight2GFX;
	import asset.knight2w1GFX;
	import asset.knight2w2GFX;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Spelare2 extends DisplayStateLayerSprite {
		
		public var m_skin:MovieClip;
		private var m_controls:EvertronControls = new EvertronControls(1); //0 = spelare 1. 1 = spelare 2.
		public var vel:int = 28; // velocity when jumping
		public var grav:int = 10; // gravity when falling
		public var footBox:Sprite; //hit box for jump checks
		public var dmgBox:Sprite;//damage box for player 2 cut attack
		public var dmgBox2:Sprite; //damage box for player 2 thrust attack
		public var hitBox:Sprite; //hitbox for player
		public var jumping:Boolean = false; //check if player is jumping
		public var inAir:Boolean = false; //check if player is falling
		public var attacking:Boolean = false;//if player is currently attacking
		public var HP2:int = 3;//player 2 HP
		public var currentPlatform:DisplayStateLayerSprite;//platform player hitchecked against
		private var platArr:Vector.<DisplayStateLayerSprite>;//platform list
		public var power:int = 0;//extra damage from powerup
		public var killCount:int;//number of monsters slain
		private var comboLog:String//keeps track of combo
		public var combo:int = 0;//extra damage from combo
		private var knightswing:SoundObject;//Swing sound
		private var rageSound:SoundObject;//Rage sound
		public var score:int = 0;//score player two
		public var inv:Boolean = false; //invurnerable check
		private var b2:Boolean = false; //Health check
		private var b1:Boolean = false; //Health check
		private var powerBool:Boolean = false; //Power check
		
		public static var m_skin:DisplayObject;
		public function Spelare2(platList) {
			super();
			this.platArr = platList;
		}//End player
		
		override public function init():void{
			this.m_initSkin();
		}//End init
		
		override public function update():void{
			keyHandler();
			checkPlat();
			checkPower();
			checkHP();
			
				if(jumping == true){jump();}
		}//End update
		
		override public function dispose():void {
			this.removeChild(m_skin);
			this.m_skin = null;
		}//End dispose
		
		private function checkPower():void {
			if (killCount > 9) {
				this.power = 1;
				inv = true;
				limitlessPower();
				Session.timer.create(7000, resetPower);
			}	
		}
		
		private function checkHP():void {
			if (HP2 == 2 && b2 == false) {
				b2 = true;
				this.removeChild(m_skin);
				this.m_skin = new knight2w1GFX();
				
				this.m_skin.scaleX = 1;
				this.m_skin.scaleY = 1;
				this.m_skin.gotoAndStop('knight2_idle');
				this.addChild(this.m_skin);
				this.footBox = new Sprite();
				//this.footBox.graphics.beginFill(0x00FF00);
				this.footBox.graphics.drawRect(-30, 33, 25, 5);
				this.footBox.graphics.endFill();
				this.m_skin.addChild(this.footBox);
				
				this.dmgBox = new Sprite();
				this.m_skin.addChild(this.dmgBox);
				
				this.hitBox = new Sprite();
				//this.hitBox.graphics.beginFill(0x000FFF);
				this.hitBox.graphics.drawRect(-26, -25, 16, 50);
				this.m_skin.addChild(hitBox);
				
				this.addChild(m_skin);
			}//End HP = 2
			
			if (HP2 == 1 && b1 == false) {
				b1 = true;
				
				this.removeChild(m_skin);
				this.m_skin = new knight2w2GFX();
				
				this.m_skin.scaleX = 1;
				this.m_skin.scaleY = 1;
				this.m_skin.gotoAndStop('knight2_idle');
				this.addChild(this.m_skin);
				this.footBox = new Sprite();
				//this.footBox.graphics.beginFill(0x00FF00);
				this.footBox.graphics.drawRect(-30, 33, 25, 5);
				this.footBox.graphics.endFill();
				this.m_skin.addChild(this.footBox);
				
				this.dmgBox = new Sprite();
				this.m_skin.addChild(this.dmgBox);
				
				this.hitBox = new Sprite();
				//this.hitBox.graphics.beginFill(0x000FFF);
				this.hitBox.graphics.drawRect(-26, -25, 16, 50);
				this.m_skin.addChild(hitBox);
				
				this.addChild(m_skin);
			}//End HP = 1
		}//End checkHP
		
		private function checkPlat():void {
			for(var i:int=0; i<platArr.length; i++) {
				if (this.footBox.hitTestObject(this.platArr[i]) && inAir == true) {
					this.jumping = false;
					this.inAir = false;
					this.y = this.platArr[i].y - 40;
					this.currentPlatform = this.platArr[i];
					break;
						}//End if
							if(this.currentPlatform && this.jumping == false){fall(); inAir = true;}
			}//End loop
		}
		
		private function keyHandler():void {
			
			if(Input.keyboard.pressed(this.m_controls.PLAYER_RIGHT) && this.m_skin.currentFrameLabel != 'knight2_death' && 
				this.x < 800 && HP2 > 0) {
				if (this.m_skin.currentFrameLabel == 'knight2_idle' && attacking == false) {
					this.m_skin.gotoAndStop('knight2_walk');
						}//End animation check
							this.m_skin.scaleX = 1;
							this.x+=6;
			}//End press right
			
			if(Input.keyboard.pressed(this.m_controls.PLAYER_LEFT) && this.m_skin.currentFrameLabel != 'knight2_death' &&
				this.x > 0 && HP2 > 0) {
				if (this.m_skin.currentFrameLabel == 'knight2_idle' && attacking == false) {
					this.m_skin.gotoAndStop('knight2_walk');
					}
						this.m_skin.scaleX = -1;
						this.x-=6;
			}//End press left
			
			if(Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_4) && inAir == false && 
				this.m_skin.currentFrameLabel != 'knight2_death' && HP2 > 0) {
					jumping = true;
					inAir = true;
						vel = 28;
			}//End press jump
			
			if(Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_1) && this.m_skin.currentFrameLabel != 'knight2_death' &&
				this.m_skin.currentFrameLabel != 'knight2_walk_attack1' && this.m_skin.currentFrameLabel != 'knight2_kombo' && 
				this.attacking == false && HP2 > 0) {
				
					Session.sound.soundChannel.sources.add('knightswing', GoodKnight.KNIGHT_SWING_SOUND);
					this.knightswing = Session.sound.soundChannel.get("knightswing");
					this.knightswing.volume = 0.2;
					this.knightswing.play();
				
					if (comboLog == '') {
							comboLog = 'a';
						}
					
					if (comboLog == 'ab') {
						this.m_skin.gotoAndStop('knight2_kombo');
							combo = 2;
							comboLog = '';
						}
					
					if(this.m_skin.currentFrameLabel != 'knight2_kombo') {
						this.m_skin.gotoAndStop('knight2_walk_attack1');
						}
					
					this.dmgBox = new Sprite();
					//this.dmgBox.graphics.beginFill(0xFF0000);
					this.dmgBox.graphics.drawRect(20, 0, 30, -50);
					this.dmgBox.graphics.drawRect(-5, -75, 30, 20);
					this.m_skin.addChild(this.dmgBox);
					Session.timer.create(250, attack);
					Session.timer.create(450, resetAtk);
			}
			
			if(Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_2) && this.m_skin.currentFrameLabel != 'knight2_death') {
				if(this.m_skin.currentFrameLabel != 'knight2_walk_attack2' && this.attacking == false && HP2 > 0) {					
					if (comboLog == 'a') {comboLog += 'b';}
					else {comboLog = ''}
					
						if (this.m_skin.currentFrameLabel != 'knight2_kombo') {
							this.m_skin.gotoAndStop('knight2_walk_attack2');
						}
			
					this.dmgBox = new Sprite();
					//this.dmgBox.graphics.beginFill(0xFF0000);
					this.dmgBox.graphics.drawRect(20, 0, 45, 15);
					this.m_skin.addChild(this.dmgBox);
					Session.timer.create(100, attack);
					Session.timer.create(340, resetAtk);
				}
			}
			
			if( Input.keyboard.justReleased(this.m_controls.PLAYER_RIGHT) ||
				Input.keyboard.justReleased(this.m_controls.PLAYER_LEFT) && HP2 > 0 && attacking == false && 
				this.m_skin.currentFrameLabel != 'knight2_death' && this.m_skin.currentFrameLabel != 'knight2_walk_attack1' &&
				this.m_skin.currentFrameLabel != 'knight2_walk_attack2' && this.m_skin.currentFrameLabel != 'knight2_kombo') {
				if( this.m_skin.currentFrameLabel != 'knight2_walk_attack1' && this.m_skin.currentFrameLabel != 'knight2_walk_attack2') {
					this.m_skin.gotoAndStop('knight2_idle');
					attacking = false;
					this.hitBox.width = 16;
					this.hitBox.height = 50;
					this.hitBox.x = 0;
					this.hitBox.y = 0;
					
				}//End set idle animation
			}//End release button
		}//End keyHandler
		
		private function jump():void {
			this.y -= vel;
			vel -= 1.2;
		}//End jump
		
		public function fall():void {
			inAir = true;
			this.y += grav;
			grav = 3.5;
		}//End fall
		
		private function m_initSkin():void {
			this.m_skin = new knight2GFX();
			this.m_skin.scaleX = 1;
			this.m_skin.scaleY = 1;
			this.m_skin.gotoAndStop('knight2_idle');
			this.addChild(this.m_skin);
			this.footBox = new Sprite();
			//this.footBox.graphics.beginFill(0x00FF00);
			this.footBox.graphics.drawRect(-30, 33, 25, 5);
			this.footBox.graphics.endFill();
			this.m_skin.addChild(this.footBox);
			
			this.dmgBox = new Sprite();
			this.m_skin.addChild(this.dmgBox);
			
			this.hitBox = new Sprite();
			//this.hitBox.graphics.beginFill(0x000FFF);
			this.hitBox.graphics.drawRect(-26, -25, 16, 50);
			this.m_skin.addChild(hitBox);
		}//End m_initSkin
		
		private function limitlessPower():void {
			if (powerBool == false) {
				powerBool = true;
				if(HP2<3){HP2 ++;}
					Session.sound.soundChannel.sources.add('rageSound', GoodKnight.RAGE);
					this.rageSound = Session.sound.soundChannel.get("rageSound");
					this.rageSound.volume = 0.5;
					this.rageSound.play();
				
			}//End if
		}//End limitlessPower
		
		private function attack():void {
			attacking = true;
		}//End attack
		
		private function resetAtk():void {
			attacking = false;
			combo = 0;
			if(this.contains(this.dmgBox)) {
				this.m_skin.removeChild(dmgBox)
			}//End if remove dmgBox
			if(this.m_skin.currentFrameLabel == 'knight2_walk_attack1' || this.m_skin.currentFrameLabel == 'knight2_walk_attack2' ||
				this.m_skin.currentFrameLabel == 'knight2_walk' || this.m_skin.currentFrameLabel == 'knight2_kombo') {
				this.m_skin.gotoAndStop('knight2_idle');
			}//End if
		}//End resetAtk
		
		private function resetPower():void {
			killCount = 0;
			inv = false;
			powerBool = false;
			power = 0;
		}//End resetPower
	}
}