
angular.module('config.route', [])

    // Collect the routes
    .constant('routes', getRoutes())

    // Configure the routes and route resolvers
    .config(['$routeProvider', 'routes',  routeConfigurator]);
    function routeConfigurator($routeProvider, routes) {

        routes.forEach(function (r) {
            //$routeProvider.when(r.url, r.config);
            setRoute(r.url, r.config);
        });
        $routeProvider.otherwise({ redirectTo: '/' });

        function setRoute(url, definition) {
            // Sets resolvers for all of the routes
            // by extending any existing resolvers (or creating a new one).
            definition.resolve = angular.extend(definition.resolve || {}, {
                prime: prime
            });
            $routeProvider.when(url, definition);
            return $routeProvider;
        }
    }
  /*  prime.$inject = ['datacontext'];

    function prime(dc) {
       
        var x = dc.primeTxnCount();
        return dc.prime();
    }*/

    // Define the routes 
    function getRoutes() {
        return [    
{
    url: '/test',
    config: {
        templateUrl: 'templates/views/test.html',
    }
},
                    {
                       url: '/',
                       config: {
                           templateUrl: '/templates/views/dashboard.html',
                           title: 'dashboard',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
                   {
                       url: '/dashboard',
                       config: {
                           templateUrl: '/templates/views/dashboard.html',
                           title: 'dashboard',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
                   {
                       url: '/billerList',
                       config: {
                           templateUrl: '/templates/views/biller/billerList.html',
                           title: 'Biller List',
                           settings: {
                               nav: 2,
                               content: 'Biller List'
                           }
                       }
                   },
                   
                   {
                       url: '/newBiller',
                       config: {
                           templateUrl: '/templates/views/biller/biller.html',
                           title: 'Biller',
                           settings: {
                               nav: 2,
                               content: 'New Biller'
                           }
                       }
                   },
                   {
                       url: '/chat',
                       config: {
                           templateUrl: '/templates/views/chatMessage/chat.html',
                           title: 'chat',
                           settings: {
                               nav: 1,
                               content: 'Chat'
                           }
                       }
                   },
                   {
                       url: '/payorList',
                       config: {
                           templateUrl: '/templates/views/payor/payorList.html',
                           title: 'Payor List',
                           settings: {
                               nav: 2,
                               content: 'Payor List'
                           }
                       }
                   },

                   {
                       url: '/newPayor',
                       config: {
                           templateUrl: '/templates/views/payor/payor.html',
                           title: 'Payor',
                           settings: {
                               nav: 2,
                               content: 'New Payor'
                           }
                       }
                   },
                   {
                       url: '/pages/lock-screen',
                       config: {
                           templateUrl: '/templates/views/pages/lock-screen.html',
                           title: 'lock-screen',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
                   {
                       url: '/pages/profile',
                       config: {
                           templateUrl: '/templates/views/pages/profile.html',
                           title: 'lock-screen',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
                   {
                       url: '/mail/inbox',
                       config: {
                           templateUrl: '/templates/views/mail/inbox.html',
                           title: 'inbox',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
                   {
                       url: '/mail/compose',
                       config: {
                           templateUrl: '/templates/views/mail/compose.html',
                           title: 'dashboard',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
                   {
                       url: '/mail/single',
                       config: {
                           templateUrl: '/templates/views/mail/single.html',
                           title: 'dashboard',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
                   {
                       url: '/tasks/tasks',
                       config: {
                           templateUrl: '/templates/views/tasks/tasks.html',
                           title: 'tasks',
                           settings: {
                               nav: 1,
                               content: '<i class="icon-dashboard"></i> Dashboard'
                           }
                       }
                   },
            {
                url: '/user',
                config: {
                    templateUrl: '/templates/views/user/user.html',
                    title: 'User List',
                    settings: {
                        nav: 8,
                        content: 'User List'
                    }
                }
            },
            {
                url: '/userSettings',
                config: {
                    templateUrl: '/templates/views/user/userSettings.html',
                    title: 'User Settings',
                    settings: {
                        nav: 8,
                        content: 'User Settings'
                    }
                }
            },
            {
                url: '/newUser',
                config: {
                    templateUrl: '/templates/views/user/newUser.html',
                    title: 'User List',
                    settings: {
                        nav: 8,
                        content: 'User List'
                    }
                }
            },
             {
                 url: '/pages/signup',
                 config: {
                     templateUrl: '/templates/views/pages/signup.html',
                     title: 'SignUp',
                     settings: {
                         nav: 8,
                         content: 'SignUp'
                     }
                 }
             },


            {
                url: '/:billerTabActive',
                config: {
                    templateUrl: '/templates/dashboard/dashboard.html',
                    title: 'dashboard',
                    settings: {
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    }
                }
            },
            {
                url: '/newTransaction/:txntype',
                config: {
                    templateUrl: '/templates/views/transaction/transaction.html',
                    title: 'create new Transaction',
                    settings: {
                        nav: 2,
                        content: 'New Transaction'
                    }
                }
            },
            {
                url: '/transactionList/:txntype',
                config: {
                    templateUrl: '/templates/views/transaction/transactionList.html',
                    title: 'Transactions',
                    settings: {
                        nav: 2,
                        content: 'Transactions'
                    }
                }
            },
            {
                url: '/editTransaction/:id',
                config: {
                    templateUrl: '/templates/views/transaction/transaction.html',
                    title: 'edit Transaction',
                    settings: {
                        nav: 3,
                        content: 'Edit Transaction'
                    }
                }
            }, {
                url: '/editTransaction/:id/isbillercurrent/:isbillercurrent',
                config: {
                    templateUrl: '/templates/transaction/transaction.html',
                    title: 'edit Transaction',
                    settings: {
                        nav: 4,
                        content: 'Edit Transaction'
                    }
                }
            },
             {
                 url: '/dispute/:id',
                 config: {
                     templateUrl: '/templates/views/transaction/dispute.html',
                     title: 'dispute Transaction',
                     settings: {
                         nav: 5,
                         content: 'Dispute Transaction'
                     }
                 }
             },
             {
                 url: '/batchdispute/:txntyp',
                 config: {
                     templateUrl: '/templates/views/transaction/batchdispute.html',
                     title: 'dispute Batch Transaction',
                     settings: {
                         nav: 6,
                         content: 'Dispute Batch Transaction'
                     }
                 }
             },             
            
             {
                 url: '/payment/:id',
                 config: {
                     templateUrl: '/templates/views/payment/payment.html',
                     title: 'Approve Transaction',
                     settings: {
                         nav: 6,
                         content: 'Approve Transaction'
                     }
                 }
             }
             ,
            {
                url: '/payanybiztemplate',
                config: {
                    templateUrl: '/templates/payanybiztemplate/payanybiztemplate.html',
                    title: 'PayAnyBiz Template',
                    settings: {
                        nav: 7,
                        content: 'PayAnyBiz Template'
                    }
                }
            }


        ];
    }



