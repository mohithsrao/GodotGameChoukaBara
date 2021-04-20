extends WATTest

var unitUnderTest:SignalResource

# Test signal to connect and disconnect to
signal signal_under_test

#test function to check connection
func _on_signal_under_test()->void:
	pass

func title() -> String:
	return "Signal Resource Unit Tests"

func pre() -> void:
	unitUnderTest = SignalResource.new()

func test_connect_signal_is_successful() -> void:
	describe("should connect to signal")
	# Arrange
	var signalString = "signal_under_test"
	var signalMethodString = "_on_signal_under_test"
	# Act
	unitUnderTest.connect_signal(signalString,self,signalMethodString)
	# Assert
	asserts.object_is_connected(self,signalString,self,signalMethodString,"Then it is connected")

func test_disconnect_signal_is_successful() -> void:
	describe("should dis-connect from signal")
	# Arrange
	var signalString = "signal_under_test"
	var signalMethodString = "_on_signal_under_test"
	# Act
	unitUnderTest.disconnect_signal(signalString,self,signalMethodString)
	# Assert
	asserts.object_is_not_connected(self,signalString,self,signalMethodString,"Then it is not connected")
	
func post() -> void:
	unitUnderTest = null
