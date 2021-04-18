extends Resource
class_name SignalResource

func connect_signal(signalName:String,connectingObjectInstance:Object,connectingMethodName:String) -> void:
	var connectionError = connectingObjectInstance.connect(signalName,connectingObjectInstance,connectingMethodName)
	assert(connectionError == OK)

func disconnect_signal(signalName:String,disconnectingObjectInstance:Object,disconnectingMethodName:String) -> void:
	if disconnectingObjectInstance.is_connected(signalName,disconnectingObjectInstance,disconnectingMethodName):
		disconnectingObjectInstance.disconnect(signalName,disconnectingObjectInstance,disconnectingMethodName)
