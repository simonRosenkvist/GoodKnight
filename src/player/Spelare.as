package player {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import asset.Knight1GFX;
	import asset.knight1w1GFX;
	import asset.knight1w2GFX;
	import asset.powerupGFX;
	import scene.Powerglow;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class Spelare extends DisplayStateLayerSprite {
		
		public var m_skin:MovieClip; //player one skin
		public var m_controls:EvertronControls = new EvertronControls(); //0 = spelare 1. 1 = spelare 2.
		public var vel:int = 28; // velocity when jumping
		public var grav:int = 10; // gravity for falling
		public var footBox:Sprite;//plater jump check hitbox
		public var dmgBox:Sprite;//player cut damagebox
		public var dmgBox2:Sprite;//player thrust damage box
		public var hitBox:Sprite; //player hitbox
		public var jumping:Boolean = false; // control for jump check
		public var inAir:Boolean = false;//control for fall check
		public var attacking:Boolean = false; //control for hit check
		private var currentPlatform:DisplayStateLayerSprite;  //platform player hitchecks with
		public var HP1:int = 3; // hit points
		private var platArr:Vector.<DisplayStateLayerSprite>; // platform list
		private var f:Platform; //floor platform
		public var power:int = 0; // When power up this i 1
		public var killCount:int;//number of monsters slain
		private var comboLog:String//Keeps track of combo
		public var combo:int = 0;//Keeps track of extra damage from combo atk.
		private var knightswing:SoundObject;//Swing sound
		private var rageSound:SoundObject;//Rage sound
		public var score:int = 0;//score player one
		public var inv:Boolean = false;//invunerable boolean
		private var powerGlow:Powerglow;//skin for powerglow
		private var powerBool:Boolean = false;//Boolean for creating powerglow effect
		private var b2:Boolean = false; //Health check
		private var b1:Boolean = false; //Health check
		
		public function Spelare(platList) {
			this.platArr = platList;
			super();
		}//End player
		
		override public function init():void {
			this.m_initSkin();
		}//End init
		
		override public function update():void {
		keyHandler();
		checkPlat();
		checkPower();
		checkHP();
			if (jumping == true) {
				jump();
			}
		
		}//End update
		
		override public function dispose():void {
		this.removeChild(m_skin);
		this.m_skin = null;	
		}
		
		private function checkHP():void {
			if (HP1 == 2 && b2 == false) {
				b2 = true;
					this.removeChild(m_skin);
					
					this.m_skin = new knight1w1GFX();
						
					this.m_skin.scaleX = 1;
					this.m_skin.scaleY = 1;
					this.m_skin.gotoAndStop('knight1_idle');
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
			
			if (HP1 == 1 && b1 == false) {
				b1 = true;
				
				this.removeChild(m_skin);
				
				this.m_skin = new knight1w2GFX();
				
				this.m_skin.scaleX = 1;
				this.m_skin.scaleY = 1;
				this.m_skin.gotoAndStop('knight1_idle');
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
		
		private function checkPower():void {
			if (killCount > 9) {
				this.power = 1;
				inv = true;
				limitlessPower();
				/*this.powerGlow = new powerupGFX();
				this.powerGlow.scaleX = 0.2;
				this.powerGlow.scaleY = 0.2;
				this.addChild(powerGlow);
				this.powerGlow.x = this.x;
				this.powerGlow.y = this.y;*/
				Session.timer.create(7000, resetPower);
			}	
		}//End checkPower
		
		private function checkPlat():void { 
			for(var i:int=0; i<platArr.length; i++) {
				if (this.footBox.hitTestObject(this.platArr[i]) && inAir == true) {
					jumping = false;
					inAir = false;
					this.y = this.platArr[i].y - 40;
					this.currentPlatform = this.platArr[i];
					break;
				}//End if
				
				if(this.currentPlatform && jumping == false){fall(); inAir = true;}
			}//End loop	
		}
		
		private function keyHandler():void {
			
			if(Input.keyboard.pressed(this.m_controls.PLAYER_RIGHT) && this.m_skin.currentFrameLabel != 'knight1_death' && 
				this.x < 800 && HP1 > 0) {
				if (this.m_skin.currentFrameLabel == 'knight1_idle' && attacking == false) {
					this.m_skin.gotoAndStop('knight1_walk');
			}//End animation check
				this.m_skin.scaleX = 1;
				this.x+=6;
		}//End press right
			
			if(Input.keyboard.pressed(this.m_controls.PLAYER_LEFT) && this.m_skin.currentFrameLabel != 'knight1_death' &&
			this.x > 0 && HP1 > 0) {
				if (this.m_skin.currentFrameLabel == 'knight1_idle' && attacking == false) {
					this.m_skin.gotoAndStop('knight1_walk');
						}
				this.m_skin.scaleX = -1;
				this.x-=6;
		}//End press left
		
		if(Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_4) && inAir == false && this.m_skin.currentFrameLabel != 'knight1_death' && 
			this.m_skin.currentFrameLabel != 'knight1_death' && HP1 > 0) {
			jumping = true;
			inAir = true;
			vel = 28;
		}//End press jump
		
		if(Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_1) && this.m_skin.currentFrameLabel != 'knight1_death') {
			if(this.m_skin.currentFrameLabel != 'knight1_walk_attack1' && this.m_skin.currentFrameLabel != 'knight1_kombo' &&
				this.attacking == false && HP1 > 0) {
				
					Session.sound.soundChannel.sources.add('knightswing', GoodKnight.KNIGHT_SWING_SOUND);
						this.knightswing = Session.sound.soundChannel.get("knightswing");
						this.knightswing.volume = 0.2;
						this.knightswing.play();
				
				if (comboLog == '') {comboLog = 'a';}
				if (comboLog == 'ab') {
					combo = 2;
					this.m_skin.gotoAndStop('knight1_kombo');
					comboLog = '';
					}
				
				if (this.m_skin.currentFrameLabel != 'knight1_kombo') {
					this.m_skin.gotoAndStop('knight1_walk_attack1');
					}
						this.dmgBox = new Sprite();
						//this.dmgBox.graphics.beginFill(0xFF0000);
						this.dmgBox.graphics.drawRect(20, 0, 30, -50);
						this.dmgBox.graphics.drawRect(-5, -75, 30, 20);
							this.m_skin.addChild(this.dmgBox);
				
				Session.timer.create(250, attack);
				Session.timer.create(450, resetAtk);
			}
		}
		
		if (Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_2) && this.m_skin.currentFrameLabel != 'knight1_death') {
			if (this.m_skin.currentFrameLabel != 'knight1_walk_attack2' && this.m_skin.currentFrameLabel != 'knight1_kombo' && 
				this.attacking == false && HP1 > 0) {
				
					Session.sound.soundChannel.sources.add('knightswing', GoodKnight.KNIGHT_SWING_SOUND);
						this.knightswing = Session.sound.soundChannel.get("knightswing");
						this.knightswing.volume = 0.2;
						this.knightswing.play();
				
					if (comboLog == 'a') {comboLog += 'b';}
					else {comboLog = ''}
				
					if(this.m_skin.currentFrameLabel != 'knight1_kombo'){this.m_skin.gotoAndStop('knight1_walk_attack2');}
					this.dmgBox = new Sprite();
					//this.dmgBox.graphics.beginFill(0xFF0000);
					this.dmgBox.graphics.drawRect(20, 0, 45, 15);
						this.m_skin.addChild(this.dmgBox);
				
				Session.timer.create(100, attack);
				Session.timer.create(340, resetAtk);
		}
	}

		if (Input.keyboard.justReleased(this.m_controls.PLAYER_RIGHT) && HP1 > 0 ||
			Input.keyboard.justReleased(this.m_controls.PLAYER_LEFT) && 
			this.m_skin.currentFrameLabel != 'knight1_death' && this.m_skin.currentFrameLabel != 'knight1_kombo') {
		if	(this.m_skin.currentFrameLabel != 'knight1_walk_attack1' &&
			this.m_skin.currentFrameLabel != 'knight1_walk_attack2') {
			this.m_skin.gotoAndStop('knight1_idle');
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
			this.m_skin = new Knight1GFX();
			this.m_skin.scaleX = 1;
			this.m_skin.scaleY = 1;
			this.m_skin.gotoAndStop('knight1_idle');
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
			
			this.powerGlow = new Powerglow(); // DOES NOT WORK
			this.powerGlow.x = 0;
			this.powerGlow.y = 0;
	
				this.addChild(this.powerGlow);
			
		}//End m_initSkin
		private function limitlessPower():void {
			if (powerBool == false) {
				powerBool = true;
				if(HP1<3){HP1 ++;}
				this.powerGlow = new Powerglow();//Fråga Henke
				this.addChild(this.powerGlow);//Se ovan
				
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
			if(this.contains(this.dmgBox)) {
				this.m_skin.removeChild(dmgBox)
			}//End if remove dmgBox
			if(this.m_skin.currentFrameLabel == 'knight1_walk_attack1' || this.m_skin.currentFrameLabel == 'knight1_walk_attack2' ||
				this.m_skin.currentFrameLabel == 'knight1_walk' || this.m_skin.currentFrameLabel == 'knight1_kombo') {
					this.m_skin.gotoAndStop('knight1_idle');
			}//End if
			combo = 0;
		}//End resetAtk
		
		private function resetPower():void {
			killCount = 0;
			powerBool = false;
			inv = false;
			power = 0;
		}//End reset power
	}
}