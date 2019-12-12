package scene {
	
	import se.lnu.stickossdk.media.SoundObject;
	
	public class Music extends SoundObject {
		
		public function Music(id:String, source:Class, unique:Boolean=false) {
			
			super(id, source, unique);
		}
	}
}