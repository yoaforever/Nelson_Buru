<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Cache;

class BizAreaController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
       
        //to optain all countrys
		if (Cache::has('biz_areas'))
		{
			return Cache::get('biz_areas');
		}else {
			$biz_areas = \App\Models\BizArea::all();
			//return $transactions_status;
			Cache::put('biz_areas', $biz_areas, 5);
			return $biz_areas;
		}
		
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create() {
       // 
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store() {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
     public function show($id) {
       $biz_areas = \App\Models\BizArea::find($id);
        $list_area = array(); 
        $counta=1;
        $list_area[0]=$biz_areas;
         $all_areas = \App\Models\BizArea::all();
            foreach ($all_areas as $areas) {
                if ($areas->id != $id) {

                    $list_area[$counta] = $areas;
                    $counta = $counta + 1;
                }
            }
           // print_r($list_area);
        return $list_area; 
        
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function edit($id) {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function update($id) {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id) {
        //
    }

}
