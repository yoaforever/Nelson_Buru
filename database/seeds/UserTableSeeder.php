<?php 

use Illuminate\Database\Seeder;
use App\User;

class UserTableSeeder extends Seeder {
 
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->delete();
 
        User::create(array(
 
            'username'    => 'admin',
            'email'         => 'admin@payanybiz.com',
            'customers_id'  =>'4',
            'active' => 1,
            'password'      => Hash::make('123') //hashes our password nicely for us
        ));
 
    }
 
}