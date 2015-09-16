<?php 

use Illuminate\Database\Seeder;
use App\Models\Role;

class RoleTableSeeder extends Seeder {
 
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('roles')->delete();
 
        Role::create(['name' => 'Admin']);
        Role::create(['name' => 'Company']);        
        Role::create(['name' => 'Employee']);
    }
 
}