var _ = require('underscore');
var request = require('request');
var async = require('async');
var Parse = require('kaiseki');
var settings = require('./settings.json');
var parse = new Parse(settings.parseAppId, settings.parseRestApiKey);

parse.loginUser(settings.parseUsername, settings.parsePassword, function (err, res, body, success) {

    // console.log('user logged in with session token = ', body.sessionToken);
    parse.sessionToken = body.sessionToken;

    request('http://sidebar.io/api', function (error, response, body) {

        if (error) {
            console.log('Error downloading data from Sidebar.io api', error);
            throw error;
        }

        var postExists = function (post, callback) {
            var query = { where: { guid: post.guid } };

            parse.getObjects('Post', query, function (error, response, posts, success) {
                if (error) {
                    console.log('Error querying Parse.com api', error);
                    throw error;
                }

                if (posts.length > 0) {
                    console.log('Post found, skipping:', post.headline);
                    return callback(false);
                }

                console.log('Post not found, queueing:', post.headline);
                return callback(true);
            });
        };

        var savePost = function (post, callback) {

            var parseObject = {
                guid: post.guid,
                title: post.headline,
                date: {
                    "__type": "Date",
                    "iso": new Date(post.date).toISOString()
                },
                author: post.author,
                url: post.url,
                twitter: post.twitterName
            };


            parse.createObject('Post', parseObject, function (error, response, body, success) {
                if (!success) {
                    console.log('Create object failed:', post.headline, body);
                    return callback(body);
                }

                console.log('Object created: ', post.headline);
                return callback();
            });
        };

        var posts = JSON.parse(body);

        //posts = _.first(posts, 1); // remove this before deploy

        // if you want to run in series use async.filterSeries
        async.filter(posts, postExists, function (results) {

            console.log('Saving %d posts to parse', results.length);

            // if you want to run in series use async.eachSeries
            async.each(results, savePost, function (error) {
                if (error) {
                    console.log('Save operation failed:', error);
                    throw error;
                }

                console.log('done');
            });
        });

    });

});






















