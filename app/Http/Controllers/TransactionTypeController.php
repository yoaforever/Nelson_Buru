<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\TransactionType;
use Cache;
class TransactionTypeController extends Controller {

    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index() {
        //to optain all countrys
        if (Cache::has('transactions_types'))
		{
			return Cache::get('transactions_types');
		}else {
			$transactions_types = \App\Models\TransactionType::all();
			//return $transactions_status;
			Cache::put('transactions_types', $transactions_types, 5);
			return $transactions_types;
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
//         $transactions_types = \App\Models\TransactionType::find($id);
//        return $transactions_types;     
        $type = TransactionType::find($id);
        $transactions_types = array(); 
        $counta=1;
        $transactions_types[0] = ($type != '') ? $type : 0;
         $all_types = TransactionType::all();
            foreach ($all_types as $types) {
                if ($types->id != $id) {

                    $transactions_types[$counta] = $types;
                    $counta = $counta + 1;
                }
            }
        return $transactions_types; 
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
