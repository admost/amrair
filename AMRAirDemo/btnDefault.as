package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class btnDefault extends MovieClip {
		private var _labelText: String;
		private var _isEnabled: Boolean = true;

		public function btnDefault() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			super();
		}

		private function onMouseUp(e: Event): void {
			if (!_isEnabled) {
				e.stopImmediatePropagation();
			}
		}

		private function onAddedToStage(e: Event): void {
			lblButton.selectable = false;

		}
		
		private function updateLabelText(): void {
			this.lblButton.text = _labelText;
		}

		public function setLabelText(labelText: String): void {
			_labelText = labelText;
			updateLabelText();
		}

		public function setIsEnabled(isEnabled: Boolean): void {
			_isEnabled = isEnabled;
		}
	}
}