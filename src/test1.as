package
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.GeolocationEvent;
	import flash.events.MediaEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	import flash.media.MediaType;
	import flash.sensors.Accelerometer;
	import flash.sensors.Geolocation;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	public class test1 extends Sprite
	{
		
		private var lat:TextField=new TextField();
		
		private var conn:SQLConnection=new SQLConnection();
		
		protected function fotoGenomen(event:MediaEvent):void
		{
			var camera:CameraRoll= new CameraRoll();
				
			var bitmapData:BitmapData = Bitmap(event.currentTarget.content).bitmapData;
			
			camera.addBitmapData(bitmapData);
			
			//testing git
		//camera.addBitmapData(d);
		
				
			
		}
		
		public function test1()
		{
			//camera
			
			var cameraUi:CameraUI=new CameraUI();
			cameraUi.addEventListener(MediaEvent.COMPLETE,fotoGenomen);
		cameraUi.launch(MediaType.IMAGE);
				
			
			//database
			
			
			//var dbFile:File = File.applicationStorageDirectory.resolvePath("mijnDB.db");
			
			//conn.addEventListener(SQLEvent.OPEN,connOpend);
			
		//	conn.openAsync(dbFile);
			
			
			//file
			
			var file:File=File.applicationDirectory.resolvePath("test.koen");
			
			var stream:FileStream=new FileStream();
			
			stream.openAsync(file,FileMode.WRITE);
			
			stream.writeUTFBytes("Sander Van Camp test het schrijven");
			stream.close();
			
			
			if(file.exists)
			{
				trace(file.url);
			
			}
			
			lat.x=100;
			lat.y=100;
			
			
			addChild(lat);
				
			super();
			
			var width:Number=Math.max(stage.fullScreenWidth,stage.fullScreenHeight);
			var height:Number=Math.min(stage.fullScreenWidth,stage.fullScreenHeight);
			
			trace(Capabilities.screenDPI);
			
			var accMeter:Accelerometer=new Accelerometer();
			
			//accMeter.addEventListener(AccelerometerEvent.UPDATE,updateAccHandler);
			
			if(Capabilities.cpuArchitecture=="")
			{
			
			
			}
			if(Geolocation.isSupported)
			{
				var geo:Geolocation=new Geolocation();
				geo.addEventListener(GeolocationEvent.UPDATE,UpdateGeoHandler);
			
			
			}
		}
		
		protected function connOpend(event:SQLEvent):void
		{
			var createtatement:SQLStatement=new SQLStatement();
			createtatement.sqlConnection=conn;
			
			var sql:String="CREATE TABLE IF NOT EXISTS studenten (" + "id INTEGER PRIMARY KEY AUTOINCREMENT,"+ " name TEXT)";
			
			createtatement.text=sql;
			createtatement.addEventListener(SQLEvent.RESULT,createResultHandler);
			createtatement.execute();
			
			
		}
		protected function createResultHandler(event:SQLEvent):void
		{
			var insertstatement:SQLStatement = new SQLStatement();
			insertstatement.sqlConnection=conn;
			
			var sqlTekst:String="Insert INTO studenten VALUES(name='koen')";
			
			insertstatement.addEventListener(SQLEvent.RESULT,SElect);
			
			insertstatement.text=sqlTekst;
			insertstatement.execute();
			
		}
		protected function SElect(Event:SQLEvent):void
		{
			var insertstatement:SQLStatement = new SQLStatement();
			insertstatement.sqlConnection=conn;
			
			var sqlTekst:String="SELECT * FROM studenten";
			
			insertstatement.addEventListener(SQLEvent.RESULT,SElect);
			
			insertstatement.text=sqlTekst;
			insertstatement.execute();
		
		}
		protected function UpdateGeoHandler(event:GeolocationEvent):void
		{
			trace("Latidude" + event.latitude + " longitude " + event.longitude);
			
			lat.text=event.latitude +"";
			
		}
		protected function updateAccHandler(event:AccelerometerEvent):void
		{
			trace("x: "+event.accelerationX);
			trace("y: " +event.accelerationY);
			
			
		
		}
	}
}