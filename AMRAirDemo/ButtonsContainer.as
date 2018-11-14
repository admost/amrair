package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import com.kokteyl.air.core.AMRSDK;
	import com.kokteyl.air.core.AMRSdkConfig;

	public class ButtonsContainer extends MovieClip {
		public function ButtonsContainer() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super();
		}

		private function onAddedToStage(e: Event): void {
			initAMR();
			setAdsCallbacks();
			setLabels();
			setMouseHandlers();
		}

		private function setLabels() {
			BTNBanner.setLabelText("Load Banner");
			BTNInterstitial.setLabelText("Load Interstitial");
			BTNRewardedVideo.setLabelText("Load Rewardedvideo");
			BTNTestSuite.setLabelText("Launch Test Suite");
		}

		private function setMouseHandlers() {
			BTNBanner.addEventListener(MouseEvent.MOUSE_UP, loadBanner);
			BTNInterstitial.addEventListener(MouseEvent.MOUSE_UP, loadInterstitial);
			BTNRewardedVideo.addEventListener(MouseEvent.MOUSE_UP, loadRewardedVideo);
			BTNTestSuite.addEventListener(MouseEvent.MOUSE_UP, launchTestSuite);
		}
		
		private function setAdsCallbacks() {
			//Banner
			AMRSDK.setOnBannerReady(onBannerReady);
			
			//Interstitial
			AMRSDK.setOnInterstitialReady(onInterstitialReady);
			AMRSDK.setOnInterstitialFail(onInterstitialFail);
			AMRSDK.setOnInterstitialShow(onInterstitialShow);
			AMRSDK.setOnInterstitialDismiss(onInterstitialDismiss);
			
			//Rewarded Video
			AMRSDK.setOnRewardedVideoReady(onRewardedVideoReady);
			AMRSDK.setOnRewardedVideoFail(onRewardedVideoFail);
			AMRSDK.setOnRewardedVideoShow(onRewardedVideoShow);
			AMRSDK.setOnRewardedVideoComplete(onRewardedVideoComplete);
			AMRSDK.setOnRewardedVideoDismiss(onRewardedVideoDismiss);
		}
		
		private function initAMR() {
			var config:AMRSdkConfig = new AMRSdkConfig();
			config.ApplicationIdIOS = "15066ddc-9c18-492c-8185-bea7e4c7f88c";
			config.BannerIdIOS = "b4009772-de04-42c4-bbaa-c18da9e4a1ab";
			config.InterstitialIdIOS = "66f31c75-e203-4e42-9aba-d66f65f23616";
			config.RewardedVideoIdIOS = "2bdefd44-5269-4cbc-b93a-373b74a2f067";
			
			config.ApplicationIdAndroid = "6cc8e89a-b52a-4e9a-bb8c-579f7ec538fe";
			config.BannerIdAndroid = "86644357-21d0-45a4-906a-37262461df65";
			config.InterstitialIdAndroid = "f99e409b-f9ab-4a2e-aa9a-4d143e6809ae";
			config.RewardedVideoIdAndroid = "88cfcfd0-2f8c-4aba-9f36-cc0ac99ab140";

	
			AMRSDK.startWithConfig(config);
		}

		// Banner
		private function loadBanner(e:Event) {
			BTNBanner.setIsEnabled(false);
			BTNBanner.setLabelText("Loading");

			AMRSDK.loadBanner(0, true); //0 top, 1 bottom
		}
		
		public function onBannerReady(networkName:String):void {
			BTNBanner.setIsEnabled(true);
			BTNBanner.setLabelText("Load Banner");
		}
		
		// Interstitial
		private function loadInterstitial(e:Event) {
			if (AMRSDK.isInterstitialReady()) {
				AMRSDK.showInterstitial();
			} else {
				BTNInterstitial.setIsEnabled(false);
				BTNInterstitial.setLabelText("Loading");
				AMRSDK.loadInterstitial();
			}
		}

		public function onInterstitialReady(networkName:String):void {
			BTNInterstitial.setIsEnabled(true);
			BTNInterstitial.setLabelText("Show Interstitial");
		}
		
		public function onInterstitialFail(errorMessage:String):void {
			trace("<AMRAIR> Error: "+ errorMessage);
			BTNInterstitial.setIsEnabled(true);
			BTNInterstitial.setLabelText("Error, Try Again");
		}

		public function onInterstitialShow(msg:String):void {}
		
		public function onInterstitialDismiss(msg:String):void {
			BTNInterstitial.setLabelText("Load Interstitial");
		}
		
		// Rewarded Video
		private function loadRewardedVideo(e:Event) {
			if (AMRSDK.isRewardedVideoReady()) {
				AMRSDK.showRewardedVideo();
			} else {
				BTNRewardedVideo.setIsEnabled(false);
				BTNRewardedVideo.setLabelText("Loading");
				AMRSDK.loadRewardedVideo();
			}
		}
		
		public function onRewardedVideoReady(networkName:String):void {
			BTNRewardedVideo.setIsEnabled(true);
			BTNRewardedVideo.setLabelText("Show Rewardedvideo");
		}
		
		public function onRewardedVideoFail(errorMessage:String):void {
			trace("<AMRAIR> Error: "+ errorMessage);
			BTNRewardedVideo.setIsEnabled(true);
			BTNRewardedVideo.setLabelText("Error, Try Again");
		}
		
		public function onRewardedVideoShow(msg:String):void {}
		
		public function onRewardedVideoDismiss(msg:String):void {
			BTNRewardedVideo.setLabelText("Load Rewardedvideo");
		}
		
		public function onRewardedVideoComplete(msg:String):void {}
		
		// test suite
		private function launchTestSuite(e:Event) {
			var zoneIds:Array = new Array("b4009772-de04-42c4-bbaa-c18da9e4a1ab","b4009772-de04-42c4-bbaa-c18da9e4a1ab","2bdefd44-5269-4cbc-b93a-373b74a2f067"); 
			AMRSDK.startTestSuite(zoneIds);
		}
	}

}