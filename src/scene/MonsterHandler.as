package scene {
	import player.Batmonster;
	import player.Monkmonster;
	import player.Spelare;
	import player.Spelare2;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	public class MonsterHandler extends DisplayState {
		private var s:Boolean;
		private var i:int;
		private var rnd:int;
		private var moveSpeed:int;
		private var moveSpeed2:int;
		private var cultistSpeed1:int;
		private var layer:DisplayStateLayer;
		private var players:Spelare;
		private var players2:Spelare2;
		public var batMonster:Batmonster;
		public var monkMonster:Monkmonster;
		public var batMonsterList:Vector.<DisplayStateLayerSprite> = new Vector.<DisplayStateLayerSprite>;
		public var cultMonsterList:Vector.<DisplayStateLayerSprite> = new Vector.<DisplayStateLayerSprite>;
		private var yArr:Vector.<int> = new Vector.<int>;
		public var heightNum:int;
		private var num:int;
		private var playerList:Vector.<DisplayStateLayerSprite> = new Vector.<DisplayStateLayerSprite>;
		public var score:int;
		private var monkmonsterhit:SoundObject;
		private var batmonsterhit:SoundObject;
		private var blood:Blood;
		private var bloodFloor:Bloodfloor;
		
		public function MonsterHandler(n_layer:DisplayStateLayer, m_player:Spelare, n_player:Spelare2, nr:int) {
		this.layer  = n_layer;
		this.players = m_player;
		this.players2 = n_player;
		this.num = nr;
		}//End constructor
		
		override public function update():void {
			batMonsterCoordinator();
			cultMonsterCoordinator();
		}
		
		public function addBat():void {
			if (num == 2) {
				this.rnd = Math.round(Math.random()*num);
			}
			this.batMonster = new Batmonster(players, players2, layer, this, num);
			this.batMonster.x = Math.random()*800;
			this.batMonster.y = -600 + Math.random()*100;
			this.batMonster.scaleX = 0.75;
			this.batMonster.scaleY = 0.75;
			
			this.batMonsterList.push(this.batMonster);
			this.layer.addChild(this.batMonster);
			batMonsterCoordinator();
		}//End addBat
		
		public function addCultist():void {
			
			this.monkMonster = new Monkmonster(players, players2, layer, this, num);
			if(Math.round(Math.random()*1) == 1) {
			this.monkMonster.x = 820 + Math.random()*50;}
			else {this.monkMonster.x = -50 -Math.random()*50;}
				this.heightNum = Math.round(Math.random()*2);	
					this.yArr.push(520);
					this.yArr.push(370);		
					this.yArr.push(170);
						this.monkMonster.y = yArr[heightNum]; // 520 370 170
					
			this.monkMonster.scaleX = 0.12;
			this.monkMonster.scaleY = 0.12;
				this.cultMonsterList.push(this.monkMonster);
					this.layer.addChild(this.monkMonster);
					
			cultMonsterCoordinator();
		}//End addCultist
		
		public function removeBat(bat):void {
			this.blood = new Blood();
			this.blood.x = bat.x - Math.random()*20;
			this.blood.y = bat.y;
			this.blood.scaleX = 0.2;
			this.blood.scaleY = 0.2;
			this.layer.addChild(this.blood);
			
			var rightBat:int = batMonsterList.indexOf(bat);
			var remove:DisplayStateLayerSprite = this.batMonsterList.splice(rightBat, 1)[0];
				layer.removeChild(remove);
					remove = null;
					
		}//End removeBat
		
		public function removeCultist(cultist):void {
			this.blood = new Blood();
			this.blood.x = cultist.x - Math.random()*20;
			this.blood.y = cultist.y - 15+Math.random()*10;
			this.blood.scaleX = 0.2;
			this.blood.scaleY = 0.2;
			this.blood.scaleZ = 0.8;
			this.layer.addChild(this.blood);
			
			this.bloodFloor = new Bloodfloor();
			this.bloodFloor.x = cultist.x - Math.random()*20;
			this.bloodFloor.y = cultist.y + 10;
			this.bloodFloor.scaleX = 0.4;
			this.bloodFloor.scaleY = 0.4;
			if (cultist.scaleX < 0) {this.bloodFloor.scaleX = -0.4;}
			this.layer.addChild(this.bloodFloor);
			
			var rightCultist:int = cultMonsterList.indexOf(cultist);
			var remove:DisplayStateLayerSprite = this.cultMonsterList.splice(rightCultist, 1)[0];
				layer.removeChild(remove);
					remove = null;
		}//End removeCultist
		
		public function batMonsterCoordinator():void {
			
			for (i=0; i<batMonsterList.length; i++){
				if (i > 3*num) { break; } 
				
				if (batMonsterList[i].inv == true) {knockback(batMonsterList[i]);}
					
					if (batMonsterList[i].target.x + 120 < batMonsterList[i].x && batMonsterList[i].m_skin.currentFrameLabel != 'batmonster_death') {
						moveSpeed = -2;
						batMonsterList[i].x += moveSpeed;
							}
					
					if (batMonsterList[i].target.x - 120 > batMonsterList[i].x && batMonsterList[i].m_skin.currentFrameLabel != 'batmonster_death') {
						moveSpeed =+2;
						batMonsterList[i].x += moveSpeed;
							}
					
					if (batMonsterList[i].x < batMonsterList[i].target.x && batMonsterList[i].m_skin.currentFrameLabel != 'batmonster_death') {
						batMonsterList[i].scaleX = -0.75;
							}
					
					if (batMonsterList[i].x > batMonsterList[i].target.x && batMonsterList[i].m_skin.currentFrameLabel != 'batmonster_death') {
						batMonsterList[i].scaleX = 0.75;
							}
					
					if (batMonsterList[i].target.y - 70 < batMonsterList[i].y && batMonsterList[i].m_skin.currentFrameLabel != 'batmonster_death') {
						moveSpeed2 = -2;
						batMonsterList[i].y += moveSpeed2;
							}
					
					if (batMonsterList[i].target.y - 70 > batMonsterList[i].y && batMonsterList[i].m_skin.currentFrameLabel != 'batmonster_death') {
						this.moveSpeed2 = +2;
						batMonsterList[i].y += moveSpeed2;
							}
					
			}//End loop
		}//End btaMonsterCoordinator
		
		public function cultMonsterCoordinator():void {
			
			for (i=0; i<cultMonsterList.length; i++) {
				
				if (cultMonsterList[i].inv == true) {knockback(cultMonsterList[i]);}
				
				if (i > 3*num){break;}
				if(cultMonsterList[i].m_skin.currentFrameLabel != 'monkmonster_death'){
				
					
					if(cultMonsterList[i].x +40 < cultMonsterList[i].target.x) {
						cultMonsterList[i].scaleX = -0.12;
					}
					if(cultMonsterList[i].x -40 > cultMonsterList[i].target.x) {
						cultMonsterList[i].scaleX = 0.12;
					}
					
					// ### MAKES CULTIST WALK LEFT OR RIGHT DEPENDING ON POSITION OF TARGET PLAYER ###
					
					if(cultMonsterList[i].target.x -60 > cultMonsterList[i].x && cultMonsterList[i].y == 170 && cultMonsterList[i].x < 250) {
						moveRight(cultMonsterList[i]);}
					if(cultMonsterList[i].target.x -60 > cultMonsterList[i].x && cultMonsterList[i].y == 170 && cultMonsterList[i].target.x > 550 && cultMonsterList[i].x > 400) {
						moveRight(cultMonsterList[i]);}
					
					
					if(cultMonsterList[i].target.x +60 < cultMonsterList[i].x && cultMonsterList[i].y == 170 && cultMonsterList[i].x > 600) {
						moveLeft(cultMonsterList[i]);}
					if(cultMonsterList[i].target.x + 60 < cultMonsterList[i].x && cultMonsterList[i].y == 170 && cultMonsterList[i].x < 400) {
						moveLeft(cultMonsterList[i]);}
					
					if(cultMonsterList[i].target.x -60 > cultMonsterList[i].x && cultMonsterList[i].y == 370 && cultMonsterList[i].x < 300) {
						moveRight(cultMonsterList[i]);}
					if(cultMonsterList[i].target.x -60 > cultMonsterList[i].x && cultMonsterList[i].y == 370 && cultMonsterList[i].target.x > 500 && cultMonsterList[i].x > 400) {
						moveRight(cultMonsterList[i]);}
					
					if(cultMonsterList[i].target.x +60 < cultMonsterList[i].x && cultMonsterList[i].y == 370 && cultMonsterList[i].x > 550) {
						moveLeft(cultMonsterList[i]);}
					if(cultMonsterList[i].target.x + 60 < cultMonsterList[i].x && cultMonsterList[i].y == 370 && cultMonsterList[i].x < 400) {
						moveLeft(cultMonsterList[i]);}
					
					if(cultMonsterList[i].target.x -60 > cultMonsterList[i].x && cultMonsterList[i].y == 520) {
						moveRight(cultMonsterList[i]);}
					
					if(cultMonsterList[i].target.x +60 < cultMonsterList[i].x && cultMonsterList[i].y == 520) {
						moveLeft(cultMonsterList[i]);}
			
		}//End death check
				
			}//End loop
		}//End cultMonsterCoordinator
		
		private function moveRight(cultist):void {
			cultist.x += 4;
		}//End moveRight
		
		private function moveLeft(cultist):void {
			cultist.x -= 4;
		}//End moveLeft

		
		private function knockback(monster):void {
			if (monster.scaleX < 0) {
				if(monster is Monkmonster) {
					if (monster.m_skin.currentFrameLabel != 'monkmonster_death') {
						Session.sound.soundChannel.sources.add('monkmonsterhit', GoodKnight.MONKMONSTER_HIT);
							this.monkmonsterhit = Session.sound.soundChannel.get("monkmonsterhit");
							this.monkmonsterhit.volume = 0.5;
							this.monkmonsterhit.play();
					}
						if (monster.m_skin.currentFrameLabel != 'monkmonster_death') {
						monster.m_skin.gotoAndStop('monkmonster_still');
					}
				}
				if (monster is Batmonster) {
					if (monster.m_skin.currentFrameLabel != 'batmonster_death') {
						Session.sound.soundChannel.sources.add('batmonsterhit', GoodKnight.MONKMONSTER_HIT);
							this.batmonsterhit = Session.sound.soundChannel.get("batmonsterhit");
							this.batmonsterhit.volume = 0.5;
							this.batmonsterhit.play();
						}
					if(monster.m_skin.currentFrameLabel != 'batmonster_death') {
						monster.m_skin.gotoAndStop('batmonster_still');
					}
				}
		
				monster.x = monster.x -2;
			}//End if
			else {
				if(monster is Monkmonster) {
					if (monster.m_skin.currentFrameLabel != 'monkmonster_death') {
						Session.sound.soundChannel.sources.add('monkmonsterhit', GoodKnight.MONKMONSTER_HIT);
							this.monkmonsterhit = Session.sound.soundChannel.get("monkmonsterhit");
							this.monkmonsterhit.volume = 0.5;
							this.monkmonsterhit.play();
						}
					
					if(monster.m_skin.currentFrameLabel != 'monkmonster_death') {
						monster.m_skin.gotoAndStop('monkmonster_still');
					}//End if death animation check
				}
				if(monster is Batmonster) {
					if (monster.m_skin.currentFrameLabel != 'batmonster_death') {
						Session.sound.soundChannel.sources.add('batmonsterhit', GoodKnight.MONKMONSTER_HIT);
							this.batmonsterhit = Session.sound.soundChannel.get("batmonsterhit");
							this.batmonsterhit.volume = 0.5;
							this.batmonsterhit.play();
						}
					
					if(monster.m_skin.currentFrameLabel != 'batmonster_death') {
						monster.m_skin.gotoAndStop('batmonster_still');
					}
				}
				monster.x = monster.x +2;
			}//End else
		}//End knockback
		
	}//End MonsterHandler
}//End package