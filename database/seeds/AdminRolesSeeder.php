<?php 

use Illuminate\Database\Seeder;
use App\Models\SystemFunction;
use App\Models\Role;

class AdminRolesSeeder extends Seeder {
 
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('role_granted_functions')->delete();
        
        $system_functions = SystemFunction::all()->lists('id');

        Role::find(Role::ROLE_ADMIN)->system_functions()->attach($system_functions);
    }
 
}