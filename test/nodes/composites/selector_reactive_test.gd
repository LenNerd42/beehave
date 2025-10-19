# GdUnit generated TestSuite
class_name SelectorReactiveTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")


# TestSuite generated from
const __source = "res://addons/beehave/nodes/composites/selector_reactive.gd"
const __count_up_action = "res://test/actions/count_up_action.gd"

var tree: BeehaveTree
var selector: BeehaveSelectorReactive
var action1: BeehaveAction
var action2: BeehaveAction


func before_test() -> void:
	tree = auto_free(BeehaveTree.new())
	action1 = auto_free(load(__count_up_action).new())
	action2 = auto_free(load(__count_up_action).new())
	selector = auto_free(BeehaveSelectorReactive.new())
	var actor = auto_free(Node2D.new())
	var blackboard = auto_free(BeehaveBlackboard.new())
	
	tree.add_child(selector)
	selector.add_child(action1)
	selector.add_child(action2)
	
	tree.actor = actor
	tree.blackboard = blackboard


@warning_ignore("unused_parameter")
func test_always_executing_first_successful_node(do_skip=true, skip_reason="Endless loop in tick()") -> void:
	var times_to_run = 2
	
	for i in range(times_to_run):
		assert_that(tree.tick()).is_equal(BeehaveTreeNode.SUCCESS)
	
	assert_that(action1.count).is_equal(times_to_run)
	assert_that(action2.count).is_equal(0)


@warning_ignore("unused_parameter")
func test_execute_second_when_first_is_failing(do_skip=true, skip_reason="Endless loop in tick()") -> void:
	var times_to_run = 2
	
	action1.status = BeehaveTreeNode.FAILURE
	action2.status = BeehaveTreeNode.SUCCESS
	
	for i in range(times_to_run):
		assert_that(tree.tick()).is_equal(BeehaveTreeNode.SUCCESS)
	
	assert_that(action1.count).is_equal(times_to_run)
	assert_that(action2.count).is_equal(times_to_run)
	


@warning_ignore("unused_parameter")
func test_return_failure_of_none_is_succeeding(do_skip=true, skip_reason="Endless loop in tick()") -> void:
	action1.status = BeehaveTreeNode.FAILURE
	action2.status = BeehaveTreeNode.FAILURE
	
	assert_that(tree.tick()).is_equal(BeehaveTreeNode.FAILURE)
	
	assert_that(action1.count).is_equal(1)
	assert_that(action2.count).is_equal(1)


@warning_ignore("unused_parameter")
func test_keeps_restarting_child_until_success(do_skip=true, skip_reason="Endless loop in tick()") -> void:
	action1.status = BeehaveTreeNode.FAILURE
	action2.status = BeehaveTreeNode.RUNNING
	
	for i in range(2):
		assert_that(tree.tick()).is_equal(BeehaveTreeNode.RUNNING)
	
	assert_that(action1.count).is_equal(2)
	assert_that(action2.count).is_equal(2)
	
	action2.status = BeehaveTreeNode.SUCCESS
	
	assert_that(tree.tick()).is_equal(BeehaveTreeNode.SUCCESS)
	assert_that(action1.count).is_equal(3)
	assert_that(action2.count).is_equal(3)
	
	assert_that(tree.tick()).is_equal(BeehaveTreeNode.SUCCESS)
	assert_that(action1.count).is_equal(4)
	assert_that(action2.count).is_equal(4)


@warning_ignore("unused_parameter")
func test_keeps_restarting_child_until_failure(do_skip=true, skip_reason="Endless loop in tick()") -> void:
	action1.status = BeehaveTreeNode.FAILURE
	action2.status = BeehaveTreeNode.RUNNING
	
	for i in range(2):
		assert_that(tree.tick()).is_equal(BeehaveTreeNode.RUNNING)
	
	assert_that(action1.count).is_equal(2)
	assert_that(action2.count).is_equal(2)
	
	action2.status = BeehaveTreeNode.FAILURE
	
	assert_that(tree.tick()).is_equal(BeehaveTreeNode.FAILURE)
	assert_that(action1.count).is_equal(3)
	assert_that(action2.count).is_equal(3)
	
	assert_that(tree.tick()).is_equal(BeehaveTreeNode.FAILURE)
	assert_that(action1.count).is_equal(4)
	assert_that(action2.count).is_equal(4)


@warning_ignore("unused_parameter")
func test_interrupt_second_when_first_is_running(do_skip=true, skip_reason="Endless loop in tick()") -> void:
	action1.status = BeehaveTreeNode.FAILURE
	action2.status = BeehaveTreeNode.RUNNING
	assert_that(tree.tick()).is_equal(BeehaveTreeNode.RUNNING)
	assert_that(action1.count).is_equal(1)
	assert_that(action2.count).is_equal(1)
	
	action1.status = BeehaveTreeNode.RUNNING
	assert_that(tree.tick()).is_equal(BeehaveTreeNode.RUNNING)
	assert_that(action1.count).is_equal(2)
	assert_that(action2.count).is_equal(0)


@warning_ignore("unused_parameter")
func test_clear_running_child_after_run(do_skip=true, skip_reason="Endless loop in tick()") -> void:
	action1.status = BeehaveTreeNode.FAILURE
	action2.status = BeehaveTreeNode.RUNNING
	tree.tick()
	assert_that(selector.running_child).is_equal(action2)
	action2.status = BeehaveTreeNode.FAILURE
	tree.tick()
	assert_that(selector.running_child).is_equal(null)
