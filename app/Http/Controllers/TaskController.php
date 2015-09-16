<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Task;
use Input;
use Response;
use DB;
use Cache;
class TaskController extends Controller {

	public function index() {
         //to optain all tasks
        return \App\Models\Task::all();
    }
	/**
	* @Desc : Saving tasks in DB.
	* @author: iblesoft
	* @input: Task Details
	* @return : all tasks
	*/
	public function create(Request $request)
	{
		$tasks = new \App\Models\Task();
		$tasks->title 		= $request->title;
		$tasks->completed	= 0;
		$tasks->users_id 	= $request->userId;
		$tasks->created_at 	= date('Y-m-d H:i:s');
		$tasks->updated_at	= date('Y-m-d H:i:s');
		$tasks->active	 	= 1;
		$tasks->save();
		return \App\Models\Task::all();
	}
	/**
	* @Desc : Saving tasks in DB.
	* @author: iblesoft
	* @input: Task Details,Task ID
	* @return : boolean
	*/
	public function update($id)
	{
		$tasks = Task::find($id);
		$tasks->title 		= Input::get('title');
		$tasks->completed	= Input::get('completed');
		$tasks->users_id 	= Input::get('users_id');
		$tasks->created_at 	= date('Y-m-d H:i:s');
		$tasks->updated_at	= date('Y-m-d H:i:s');
		$tasks->active	 	= true;
		$tasks->save();
		return 1;
	}
	/**
	* @Desc : Mark all tasks as done.
	* @author: iblesoft
	* @input: Task Details,Task ID
	* @return : all tasks
	*/
	
	public function mark_all()
	{
		$result = DB::table('pabtasks')->update(array('completed' => 1));
		return 1;
	}
	public function active_tasks()
	{
		return DB::table('pabtasks')->where('active', '=', 1)->where('completed', '=', 0)->get();
	}
	
	
	public function destroy($id) {
		$tasks = \App\Models\Task::destroy($id);
        return \App\Models\Task::all();
        
    }
	
}
