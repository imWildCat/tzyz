(function () {
    var ready;
    ready = function () {
        $.extend({
            enable_at_user: function () {
                // only enable once
                if (window.has_enabled_at_user)
                    return;
                $('[contenteditable="true"]').textcomplete([
                    {
                        match: /\B@([\u4e00-\u9fa5\w]+)$/,
                        search: function (term, callback) {
                            //console.log('term is: '+ term);
                            var callCb = function (data) {
                                $.setCurrentUserTerm(data);
                                var mentions = [];
                                for (var i = 0; i < data.length; i++) {
                                    mentions.push(data[i].title);
                                }
                                callback($.map(mentions, function (mention) {
                                    return mention;
                                }));
                            };
                            // Initilize cache
                            if (!window.userTermCache) {
                                //console.log('init cache');
                                window.userTermCache = {};
                            }
                            // If there is a cached data, load form it
                            if (window.userTermCache[term] != null) {
                                //console.log('load from cache');
                                callCb(window.userTermCache[term]);
                                return;
                            }
                            $.ajax({
                                dataType: 'json',
                                url: '/quick_search/u?q=' + term,
                            }).done(function (data) {
                                //console.log('load from server');
                                window.userTermCache[term] = data;
                                callCb(data);
                            });
                        },
                        index: 1,
                        template: function (value) {
                            var currentUser = $.fetchCurrentUserTerm();
                            var output;
                            if (currentUser) {
                                output = value + ' (<span style="font-weight:bold">' + currentUser.id + '</span>)';
                            }
                            else output = value;
                            return output;

                        },
                        replace: function (mention) {
                            return '@' + mention + ' ';
                        }
                    }
                ], {appendTo: 'body'});

                $('[contenteditable="true"]').overlay([
                    {
                        match: /\B@\w+/g,
                        css: {
                            'background-color': '#d8dfea'
                        }
                    }
                ]);

                window.has_enabled_at_user = true;
            },
            currentUserTermData: [],
            currentTermDataIndex: 0,
            setCurrentUserTerm: function (data) {
                $.currentUserTermData = data;
                $.currentTermDataIndex = 0;
            },
            fetchCurrentUserTerm: function () {
                $.currentTermDataIndex++;
                if ($.currentUserTermData && $.currentUserTermData[$.currentTermDataIndex - 1]) {
                    return $.currentUserTermData[$.currentTermDataIndex - 1];
                }
                return null;
            }
            //disable_at_user: function () {
            //    $('[contenteditable="true"]').textcomplete('destroy');
            //}
        });

    };

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();