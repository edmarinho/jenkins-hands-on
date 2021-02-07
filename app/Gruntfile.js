module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      options: {
        livereload: true,
      },
      css: {
        files: ['./css/*.css'],
      },
      js: {
        files: ['Gruntfile.js', './js/*.js'],
      },
      html: {
        files: ['index.html', './**/*.html'],
      }
    },
    connect: {
      server: {
        options: {
          port: 9090,
          base: '.',
          hostname: 'localhost',
          protocol: 'http',
          livereload: true,
          open: true,
        }
      }
    },
  });

  // Grunts plugins
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');

  // Default task(s).
  grunt.registerTask('default', 'Log something', function(){
    grunt.log.writeln('Excelente!');
  });

  grunt.registerTask('server', [
    'connect',
    'watch'
  ]);
};
