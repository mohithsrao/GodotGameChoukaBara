extends WATTest

func title() -> String:
	return "Integration Test Demo"

func test_this_is_a_demo_integration_test() -> void:
	asserts.is_true(true)
