/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 29);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

module.exports = require("path");

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

var fs = __webpack_require__(4)
var polyfills = __webpack_require__(32)
var legacy = __webpack_require__(34)
var queue = []

var util = __webpack_require__(7)

function noop () {}

var debug = noop
if (util.debuglog)
  debug = util.debuglog('gfs4')
else if (/\bgfs4\b/i.test(process.env.NODE_DEBUG || ''))
  debug = function() {
    var m = util.format.apply(util, arguments)
    m = 'GFS4: ' + m.split(/\n/).join('\nGFS4: ')
    console.error(m)
  }

if (/\bgfs4\b/i.test(process.env.NODE_DEBUG || '')) {
  process.on('exit', function() {
    debug(queue)
    __webpack_require__(8).equal(queue.length, 0)
  })
}

module.exports = patch(__webpack_require__(15))
if (process.env.TEST_GRACEFUL_FS_GLOBAL_PATCH) {
  module.exports = patch(fs)
}

// Always patch fs.close/closeSync, because we want to
// retry() whenever a close happens *anywhere* in the program.
// This is essential when multiple graceful-fs instances are
// in play at the same time.
module.exports.close =
fs.close = (function (fs$close) { return function (fd, cb) {
  return fs$close.call(fs, fd, function (err) {
    if (!err)
      retry()

    if (typeof cb === 'function')
      cb.apply(this, arguments)
  })
}})(fs.close)

module.exports.closeSync =
fs.closeSync = (function (fs$closeSync) { return function (fd) {
  // Note that graceful-fs also retries when fs.closeSync() fails.
  // Looks like a bug to me, although it's probably a harmless one.
  var rval = fs$closeSync.apply(fs, arguments)
  retry()
  return rval
}})(fs.closeSync)

function patch (fs) {
  // Everything that references the open() function needs to be in here
  polyfills(fs)
  fs.gracefulify = patch
  fs.FileReadStream = ReadStream;  // Legacy name.
  fs.FileWriteStream = WriteStream;  // Legacy name.
  fs.createReadStream = createReadStream
  fs.createWriteStream = createWriteStream
  var fs$readFile = fs.readFile
  fs.readFile = readFile
  function readFile (path, options, cb) {
    if (typeof options === 'function')
      cb = options, options = null

    return go$readFile(path, options, cb)

    function go$readFile (path, options, cb) {
      return fs$readFile(path, options, function (err) {
        if (err && (err.code === 'EMFILE' || err.code === 'ENFILE'))
          enqueue([go$readFile, [path, options, cb]])
        else {
          if (typeof cb === 'function')
            cb.apply(this, arguments)
          retry()
        }
      })
    }
  }

  var fs$writeFile = fs.writeFile
  fs.writeFile = writeFile
  function writeFile (path, data, options, cb) {
    if (typeof options === 'function')
      cb = options, options = null

    return go$writeFile(path, data, options, cb)

    function go$writeFile (path, data, options, cb) {
      return fs$writeFile(path, data, options, function (err) {
        if (err && (err.code === 'EMFILE' || err.code === 'ENFILE'))
          enqueue([go$writeFile, [path, data, options, cb]])
        else {
          if (typeof cb === 'function')
            cb.apply(this, arguments)
          retry()
        }
      })
    }
  }

  var fs$appendFile = fs.appendFile
  if (fs$appendFile)
    fs.appendFile = appendFile
  function appendFile (path, data, options, cb) {
    if (typeof options === 'function')
      cb = options, options = null

    return go$appendFile(path, data, options, cb)

    function go$appendFile (path, data, options, cb) {
      return fs$appendFile(path, data, options, function (err) {
        if (err && (err.code === 'EMFILE' || err.code === 'ENFILE'))
          enqueue([go$appendFile, [path, data, options, cb]])
        else {
          if (typeof cb === 'function')
            cb.apply(this, arguments)
          retry()
        }
      })
    }
  }

  var fs$readdir = fs.readdir
  fs.readdir = readdir
  function readdir (path, options, cb) {
    var args = [path]
    if (typeof options !== 'function') {
      args.push(options)
    } else {
      cb = options
    }
    args.push(go$readdir$cb)

    return go$readdir(args)

    function go$readdir$cb (err, files) {
      if (files && files.sort)
        files.sort()

      if (err && (err.code === 'EMFILE' || err.code === 'ENFILE'))
        enqueue([go$readdir, [args]])
      else {
        if (typeof cb === 'function')
          cb.apply(this, arguments)
        retry()
      }
    }
  }

  function go$readdir (args) {
    return fs$readdir.apply(fs, args)
  }

  if (process.version.substr(0, 4) === 'v0.8') {
    var legStreams = legacy(fs)
    ReadStream = legStreams.ReadStream
    WriteStream = legStreams.WriteStream
  }

  var fs$ReadStream = fs.ReadStream
  ReadStream.prototype = Object.create(fs$ReadStream.prototype)
  ReadStream.prototype.open = ReadStream$open

  var fs$WriteStream = fs.WriteStream
  WriteStream.prototype = Object.create(fs$WriteStream.prototype)
  WriteStream.prototype.open = WriteStream$open

  fs.ReadStream = ReadStream
  fs.WriteStream = WriteStream

  function ReadStream (path, options) {
    if (this instanceof ReadStream)
      return fs$ReadStream.apply(this, arguments), this
    else
      return ReadStream.apply(Object.create(ReadStream.prototype), arguments)
  }

  function ReadStream$open () {
    var that = this
    open(that.path, that.flags, that.mode, function (err, fd) {
      if (err) {
        if (that.autoClose)
          that.destroy()

        that.emit('error', err)
      } else {
        that.fd = fd
        that.emit('open', fd)
        that.read()
      }
    })
  }

  function WriteStream (path, options) {
    if (this instanceof WriteStream)
      return fs$WriteStream.apply(this, arguments), this
    else
      return WriteStream.apply(Object.create(WriteStream.prototype), arguments)
  }

  function WriteStream$open () {
    var that = this
    open(that.path, that.flags, that.mode, function (err, fd) {
      if (err) {
        that.destroy()
        that.emit('error', err)
      } else {
        that.fd = fd
        that.emit('open', fd)
      }
    })
  }

  function createReadStream (path, options) {
    return new ReadStream(path, options)
  }

  function createWriteStream (path, options) {
    return new WriteStream(path, options)
  }

  var fs$open = fs.open
  fs.open = open
  function open (path, flags, mode, cb) {
    if (typeof mode === 'function')
      cb = mode, mode = null

    return go$open(path, flags, mode, cb)

    function go$open (path, flags, mode, cb) {
      return fs$open(path, flags, mode, function (err, fd) {
        if (err && (err.code === 'EMFILE' || err.code === 'ENFILE'))
          enqueue([go$open, [path, flags, mode, cb]])
        else {
          if (typeof cb === 'function')
            cb.apply(this, arguments)
          retry()
        }
      })
    }
  }

  return fs
}

function enqueue (elem) {
  debug('ENQUEUE', elem[0].name, elem[1])
  queue.push(elem)
}

function retry () {
  var elem = queue.shift()
  if (elem) {
    debug('RETRY', elem[0].name, elem[1])
    elem[0].apply(null, elem[1])
  }
}


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


exports.fromCallback = function (fn) {
  return Object.defineProperty(function () {
    if (typeof arguments[arguments.length - 1] === 'function') fn.apply(this, arguments)
    else {
      return new Promise((resolve, reject) => {
        arguments[arguments.length] = (err, res) => {
          if (err) return reject(err)
          resolve(res)
        }
        arguments.length++
        fn.apply(this, arguments)
      })
    }
  }, 'name', { value: fn.name })
}

exports.fromPromise = function (fn) {
  return Object.defineProperty(function () {
    const cb = arguments[arguments.length - 1]
    if (typeof cb !== 'function') return fn.apply(this, arguments)
    else fn.apply(this, arguments).then(r => cb(null, r), cb)
  }, 'name', { value: fn.name })
}


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

const u = __webpack_require__(2).fromCallback
const mkdirs = u(__webpack_require__(36))
const mkdirsSync = __webpack_require__(37)

module.exports = {
  mkdirs: mkdirs,
  mkdirsSync: mkdirsSync,
  // alias
  mkdirp: mkdirs,
  mkdirpSync: mkdirsSync,
  ensureDir: mkdirs,
  ensureDirSync: mkdirsSync
}


/***/ }),
/* 4 */
/***/ (function(module, exports) {

module.exports = require("fs");

/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

const u = __webpack_require__(2).fromPromise
const fs = __webpack_require__(14)

function pathExists (path) {
  return fs.access(path).then(() => true).catch(() => false)
}

module.exports = {
  pathExists: u(pathExists),
  pathExistsSync: fs.existsSync
}


/***/ }),
/* 6 */
/***/ (function(module, exports) {

module.exports = require("stream");

/***/ }),
/* 7 */
/***/ (function(module, exports) {

module.exports = require("util");

/***/ }),
/* 8 */
/***/ (function(module, exports) {

module.exports = require("assert");

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const rimraf = __webpack_require__(40)

module.exports = {
  remove: u(rimraf),
  removeSync: rimraf.sync
}


/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const jsonFile = __webpack_require__(42)

module.exports = {
  // jsonfile exports
  readJson: u(jsonFile.readFile),
  readJsonSync: jsonFile.readFileSync,
  writeJson: u(jsonFile.writeFile),
  writeJsonSync: jsonFile.writeFileSync
}


/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = minimatch
minimatch.Minimatch = Minimatch

var path = { sep: '/' }
try {
  path = __webpack_require__(0)
} catch (er) {}

var GLOBSTAR = minimatch.GLOBSTAR = Minimatch.GLOBSTAR = {}
var expand = __webpack_require__(66)

var plTypes = {
  '!': { open: '(?:(?!(?:', close: '))[^/]*?)'},
  '?': { open: '(?:', close: ')?' },
  '+': { open: '(?:', close: ')+' },
  '*': { open: '(?:', close: ')*' },
  '@': { open: '(?:', close: ')' }
}

// any single thing other than /
// don't need to escape / when using new RegExp()
var qmark = '[^/]'

// * => any number of characters
var star = qmark + '*?'

// ** when dots are allowed.  Anything goes, except .. and .
// not (^ or / followed by one or two dots followed by $ or /),
// followed by anything, any number of times.
var twoStarDot = '(?:(?!(?:\\\/|^)(?:\\.{1,2})($|\\\/)).)*?'

// not a ^ or / followed by a dot,
// followed by anything, any number of times.
var twoStarNoDot = '(?:(?!(?:\\\/|^)\\.).)*?'

// characters that need to be escaped in RegExp.
var reSpecials = charSet('().*{}+?[]^$\\!')

// "abc" -> { a:true, b:true, c:true }
function charSet (s) {
  return s.split('').reduce(function (set, c) {
    set[c] = true
    return set
  }, {})
}

// normalizes slashes.
var slashSplit = /\/+/

minimatch.filter = filter
function filter (pattern, options) {
  options = options || {}
  return function (p, i, list) {
    return minimatch(p, pattern, options)
  }
}

function ext (a, b) {
  a = a || {}
  b = b || {}
  var t = {}
  Object.keys(b).forEach(function (k) {
    t[k] = b[k]
  })
  Object.keys(a).forEach(function (k) {
    t[k] = a[k]
  })
  return t
}

minimatch.defaults = function (def) {
  if (!def || !Object.keys(def).length) return minimatch

  var orig = minimatch

  var m = function minimatch (p, pattern, options) {
    return orig.minimatch(p, pattern, ext(def, options))
  }

  m.Minimatch = function Minimatch (pattern, options) {
    return new orig.Minimatch(pattern, ext(def, options))
  }

  return m
}

Minimatch.defaults = function (def) {
  if (!def || !Object.keys(def).length) return Minimatch
  return minimatch.defaults(def).Minimatch
}

function minimatch (p, pattern, options) {
  if (typeof pattern !== 'string') {
    throw new TypeError('glob pattern string required')
  }

  if (!options) options = {}

  // shortcut: comments match nothing.
  if (!options.nocomment && pattern.charAt(0) === '#') {
    return false
  }

  // "" only matches ""
  if (pattern.trim() === '') return p === ''

  return new Minimatch(pattern, options).match(p)
}

function Minimatch (pattern, options) {
  if (!(this instanceof Minimatch)) {
    return new Minimatch(pattern, options)
  }

  if (typeof pattern !== 'string') {
    throw new TypeError('glob pattern string required')
  }

  if (!options) options = {}
  pattern = pattern.trim()

  // windows support: need to use /, not \
  if (path.sep !== '/') {
    pattern = pattern.split(path.sep).join('/')
  }

  this.options = options
  this.set = []
  this.pattern = pattern
  this.regexp = null
  this.negate = false
  this.comment = false
  this.empty = false

  // make the set of regexps etc.
  this.make()
}

Minimatch.prototype.debug = function () {}

Minimatch.prototype.make = make
function make () {
  // don't do it more than once.
  if (this._made) return

  var pattern = this.pattern
  var options = this.options

  // empty patterns and comments match nothing.
  if (!options.nocomment && pattern.charAt(0) === '#') {
    this.comment = true
    return
  }
  if (!pattern) {
    this.empty = true
    return
  }

  // step 1: figure out negation, etc.
  this.parseNegate()

  // step 2: expand braces
  var set = this.globSet = this.braceExpand()

  if (options.debug) this.debug = console.error

  this.debug(this.pattern, set)

  // step 3: now we have a set, so turn each one into a series of path-portion
  // matching patterns.
  // These will be regexps, except in the case of "**", which is
  // set to the GLOBSTAR object for globstar behavior,
  // and will not contain any / characters
  set = this.globParts = set.map(function (s) {
    return s.split(slashSplit)
  })

  this.debug(this.pattern, set)

  // glob --> regexps
  set = set.map(function (s, si, set) {
    return s.map(this.parse, this)
  }, this)

  this.debug(this.pattern, set)

  // filter out everything that didn't compile properly.
  set = set.filter(function (s) {
    return s.indexOf(false) === -1
  })

  this.debug(this.pattern, set)

  this.set = set
}

Minimatch.prototype.parseNegate = parseNegate
function parseNegate () {
  var pattern = this.pattern
  var negate = false
  var options = this.options
  var negateOffset = 0

  if (options.nonegate) return

  for (var i = 0, l = pattern.length
    ; i < l && pattern.charAt(i) === '!'
    ; i++) {
    negate = !negate
    negateOffset++
  }

  if (negateOffset) this.pattern = pattern.substr(negateOffset)
  this.negate = negate
}

// Brace expansion:
// a{b,c}d -> abd acd
// a{b,}c -> abc ac
// a{0..3}d -> a0d a1d a2d a3d
// a{b,c{d,e}f}g -> abg acdfg acefg
// a{b,c}d{e,f}g -> abdeg acdeg abdeg abdfg
//
// Invalid sets are not expanded.
// a{2..}b -> a{2..}b
// a{b}c -> a{b}c
minimatch.braceExpand = function (pattern, options) {
  return braceExpand(pattern, options)
}

Minimatch.prototype.braceExpand = braceExpand

function braceExpand (pattern, options) {
  if (!options) {
    if (this instanceof Minimatch) {
      options = this.options
    } else {
      options = {}
    }
  }

  pattern = typeof pattern === 'undefined'
    ? this.pattern : pattern

  if (typeof pattern === 'undefined') {
    throw new TypeError('undefined pattern')
  }

  if (options.nobrace ||
    !pattern.match(/\{.*\}/)) {
    // shortcut. no need to expand.
    return [pattern]
  }

  return expand(pattern)
}

// parse a component of the expanded set.
// At this point, no pattern may contain "/" in it
// so we're going to return a 2d array, where each entry is the full
// pattern, split on '/', and then turned into a regular expression.
// A regexp is made at the end which joins each array with an
// escaped /, and another full one which joins each regexp with |.
//
// Following the lead of Bash 4.1, note that "**" only has special meaning
// when it is the *only* thing in a path portion.  Otherwise, any series
// of * is equivalent to a single *.  Globstar behavior is enabled by
// default, and can be disabled by setting options.noglobstar.
Minimatch.prototype.parse = parse
var SUBPARSE = {}
function parse (pattern, isSub) {
  if (pattern.length > 1024 * 64) {
    throw new TypeError('pattern is too long')
  }

  var options = this.options

  // shortcuts
  if (!options.noglobstar && pattern === '**') return GLOBSTAR
  if (pattern === '') return ''

  var re = ''
  var hasMagic = !!options.nocase
  var escaping = false
  // ? => one single character
  var patternListStack = []
  var negativeLists = []
  var stateChar
  var inClass = false
  var reClassStart = -1
  var classStart = -1
  // . and .. never match anything that doesn't start with .,
  // even when options.dot is set.
  var patternStart = pattern.charAt(0) === '.' ? '' // anything
  // not (start or / followed by . or .. followed by / or end)
  : options.dot ? '(?!(?:^|\\\/)\\.{1,2}(?:$|\\\/))'
  : '(?!\\.)'
  var self = this

  function clearStateChar () {
    if (stateChar) {
      // we had some state-tracking character
      // that wasn't consumed by this pass.
      switch (stateChar) {
        case '*':
          re += star
          hasMagic = true
        break
        case '?':
          re += qmark
          hasMagic = true
        break
        default:
          re += '\\' + stateChar
        break
      }
      self.debug('clearStateChar %j %j', stateChar, re)
      stateChar = false
    }
  }

  for (var i = 0, len = pattern.length, c
    ; (i < len) && (c = pattern.charAt(i))
    ; i++) {
    this.debug('%s\t%s %s %j', pattern, i, re, c)

    // skip over any that are escaped.
    if (escaping && reSpecials[c]) {
      re += '\\' + c
      escaping = false
      continue
    }

    switch (c) {
      case '/':
        // completely not allowed, even escaped.
        // Should already be path-split by now.
        return false

      case '\\':
        clearStateChar()
        escaping = true
      continue

      // the various stateChar values
      // for the "extglob" stuff.
      case '?':
      case '*':
      case '+':
      case '@':
      case '!':
        this.debug('%s\t%s %s %j <-- stateChar', pattern, i, re, c)

        // all of those are literals inside a class, except that
        // the glob [!a] means [^a] in regexp
        if (inClass) {
          this.debug('  in class')
          if (c === '!' && i === classStart + 1) c = '^'
          re += c
          continue
        }

        // if we already have a stateChar, then it means
        // that there was something like ** or +? in there.
        // Handle the stateChar, then proceed with this one.
        self.debug('call clearStateChar %j', stateChar)
        clearStateChar()
        stateChar = c
        // if extglob is disabled, then +(asdf|foo) isn't a thing.
        // just clear the statechar *now*, rather than even diving into
        // the patternList stuff.
        if (options.noext) clearStateChar()
      continue

      case '(':
        if (inClass) {
          re += '('
          continue
        }

        if (!stateChar) {
          re += '\\('
          continue
        }

        patternListStack.push({
          type: stateChar,
          start: i - 1,
          reStart: re.length,
          open: plTypes[stateChar].open,
          close: plTypes[stateChar].close
        })
        // negation is (?:(?!js)[^/]*)
        re += stateChar === '!' ? '(?:(?!(?:' : '(?:'
        this.debug('plType %j %j', stateChar, re)
        stateChar = false
      continue

      case ')':
        if (inClass || !patternListStack.length) {
          re += '\\)'
          continue
        }

        clearStateChar()
        hasMagic = true
        var pl = patternListStack.pop()
        // negation is (?:(?!js)[^/]*)
        // The others are (?:<pattern>)<type>
        re += pl.close
        if (pl.type === '!') {
          negativeLists.push(pl)
        }
        pl.reEnd = re.length
      continue

      case '|':
        if (inClass || !patternListStack.length || escaping) {
          re += '\\|'
          escaping = false
          continue
        }

        clearStateChar()
        re += '|'
      continue

      // these are mostly the same in regexp and glob
      case '[':
        // swallow any state-tracking char before the [
        clearStateChar()

        if (inClass) {
          re += '\\' + c
          continue
        }

        inClass = true
        classStart = i
        reClassStart = re.length
        re += c
      continue

      case ']':
        //  a right bracket shall lose its special
        //  meaning and represent itself in
        //  a bracket expression if it occurs
        //  first in the list.  -- POSIX.2 2.8.3.2
        if (i === classStart + 1 || !inClass) {
          re += '\\' + c
          escaping = false
          continue
        }

        // handle the case where we left a class open.
        // "[z-a]" is valid, equivalent to "\[z-a\]"
        if (inClass) {
          // split where the last [ was, make sure we don't have
          // an invalid re. if so, re-walk the contents of the
          // would-be class to re-translate any characters that
          // were passed through as-is
          // TODO: It would probably be faster to determine this
          // without a try/catch and a new RegExp, but it's tricky
          // to do safely.  For now, this is safe and works.
          var cs = pattern.substring(classStart + 1, i)
          try {
            RegExp('[' + cs + ']')
          } catch (er) {
            // not a valid class!
            var sp = this.parse(cs, SUBPARSE)
            re = re.substr(0, reClassStart) + '\\[' + sp[0] + '\\]'
            hasMagic = hasMagic || sp[1]
            inClass = false
            continue
          }
        }

        // finish up the class.
        hasMagic = true
        inClass = false
        re += c
      continue

      default:
        // swallow any state char that wasn't consumed
        clearStateChar()

        if (escaping) {
          // no need
          escaping = false
        } else if (reSpecials[c]
          && !(c === '^' && inClass)) {
          re += '\\'
        }

        re += c

    } // switch
  } // for

  // handle the case where we left a class open.
  // "[abc" is valid, equivalent to "\[abc"
  if (inClass) {
    // split where the last [ was, and escape it
    // this is a huge pita.  We now have to re-walk
    // the contents of the would-be class to re-translate
    // any characters that were passed through as-is
    cs = pattern.substr(classStart + 1)
    sp = this.parse(cs, SUBPARSE)
    re = re.substr(0, reClassStart) + '\\[' + sp[0]
    hasMagic = hasMagic || sp[1]
  }

  // handle the case where we had a +( thing at the *end*
  // of the pattern.
  // each pattern list stack adds 3 chars, and we need to go through
  // and escape any | chars that were passed through as-is for the regexp.
  // Go through and escape them, taking care not to double-escape any
  // | chars that were already escaped.
  for (pl = patternListStack.pop(); pl; pl = patternListStack.pop()) {
    var tail = re.slice(pl.reStart + pl.open.length)
    this.debug('setting tail', re, pl)
    // maybe some even number of \, then maybe 1 \, followed by a |
    tail = tail.replace(/((?:\\{2}){0,64})(\\?)\|/g, function (_, $1, $2) {
      if (!$2) {
        // the | isn't already escaped, so escape it.
        $2 = '\\'
      }

      // need to escape all those slashes *again*, without escaping the
      // one that we need for escaping the | character.  As it works out,
      // escaping an even number of slashes can be done by simply repeating
      // it exactly after itself.  That's why this trick works.
      //
      // I am sorry that you have to see this.
      return $1 + $1 + $2 + '|'
    })

    this.debug('tail=%j\n   %s', tail, tail, pl, re)
    var t = pl.type === '*' ? star
      : pl.type === '?' ? qmark
      : '\\' + pl.type

    hasMagic = true
    re = re.slice(0, pl.reStart) + t + '\\(' + tail
  }

  // handle trailing things that only matter at the very end.
  clearStateChar()
  if (escaping) {
    // trailing \\
    re += '\\\\'
  }

  // only need to apply the nodot start if the re starts with
  // something that could conceivably capture a dot
  var addPatternStart = false
  switch (re.charAt(0)) {
    case '.':
    case '[':
    case '(': addPatternStart = true
  }

  // Hack to work around lack of negative lookbehind in JS
  // A pattern like: *.!(x).!(y|z) needs to ensure that a name
  // like 'a.xyz.yz' doesn't match.  So, the first negative
  // lookahead, has to look ALL the way ahead, to the end of
  // the pattern.
  for (var n = negativeLists.length - 1; n > -1; n--) {
    var nl = negativeLists[n]

    var nlBefore = re.slice(0, nl.reStart)
    var nlFirst = re.slice(nl.reStart, nl.reEnd - 8)
    var nlLast = re.slice(nl.reEnd - 8, nl.reEnd)
    var nlAfter = re.slice(nl.reEnd)

    nlLast += nlAfter

    // Handle nested stuff like *(*.js|!(*.json)), where open parens
    // mean that we should *not* include the ) in the bit that is considered
    // "after" the negated section.
    var openParensBefore = nlBefore.split('(').length - 1
    var cleanAfter = nlAfter
    for (i = 0; i < openParensBefore; i++) {
      cleanAfter = cleanAfter.replace(/\)[+*?]?/, '')
    }
    nlAfter = cleanAfter

    var dollar = ''
    if (nlAfter === '' && isSub !== SUBPARSE) {
      dollar = '$'
    }
    var newRe = nlBefore + nlFirst + nlAfter + dollar + nlLast
    re = newRe
  }

  // if the re is not "" at this point, then we need to make sure
  // it doesn't match against an empty path part.
  // Otherwise a/* will match a/, which it should not.
  if (re !== '' && hasMagic) {
    re = '(?=.)' + re
  }

  if (addPatternStart) {
    re = patternStart + re
  }

  // parsing just a piece of a larger pattern.
  if (isSub === SUBPARSE) {
    return [re, hasMagic]
  }

  // skip the regexp for non-magical patterns
  // unescape anything in it, though, so that it'll be
  // an exact match against a file etc.
  if (!hasMagic) {
    return globUnescape(pattern)
  }

  var flags = options.nocase ? 'i' : ''
  try {
    var regExp = new RegExp('^' + re + '$', flags)
  } catch (er) {
    // If it was an invalid regular expression, then it can't match
    // anything.  This trick looks for a character after the end of
    // the string, which is of course impossible, except in multi-line
    // mode, but it's not a /m regex.
    return new RegExp('$.')
  }

  regExp._glob = pattern
  regExp._src = re

  return regExp
}

minimatch.makeRe = function (pattern, options) {
  return new Minimatch(pattern, options || {}).makeRe()
}

Minimatch.prototype.makeRe = makeRe
function makeRe () {
  if (this.regexp || this.regexp === false) return this.regexp

  // at this point, this.set is a 2d array of partial
  // pattern strings, or "**".
  //
  // It's better to use .match().  This function shouldn't
  // be used, really, but it's pretty convenient sometimes,
  // when you just want to work with a regex.
  var set = this.set

  if (!set.length) {
    this.regexp = false
    return this.regexp
  }
  var options = this.options

  var twoStar = options.noglobstar ? star
    : options.dot ? twoStarDot
    : twoStarNoDot
  var flags = options.nocase ? 'i' : ''

  var re = set.map(function (pattern) {
    return pattern.map(function (p) {
      return (p === GLOBSTAR) ? twoStar
      : (typeof p === 'string') ? regExpEscape(p)
      : p._src
    }).join('\\\/')
  }).join('|')

  // must match entire pattern
  // ending in a * or ** will make it less strict.
  re = '^(?:' + re + ')$'

  // can match anything, as long as it's not this.
  if (this.negate) re = '^(?!' + re + ').*$'

  try {
    this.regexp = new RegExp(re, flags)
  } catch (ex) {
    this.regexp = false
  }
  return this.regexp
}

minimatch.match = function (list, pattern, options) {
  options = options || {}
  var mm = new Minimatch(pattern, options)
  list = list.filter(function (f) {
    return mm.match(f)
  })
  if (mm.options.nonull && !list.length) {
    list.push(pattern)
  }
  return list
}

Minimatch.prototype.match = match
function match (f, partial) {
  this.debug('match', f, this.pattern)
  // short-circuit in the case of busted things.
  // comments, etc.
  if (this.comment) return false
  if (this.empty) return f === ''

  if (f === '/' && partial) return true

  var options = this.options

  // windows: need to use /, not \
  if (path.sep !== '/') {
    f = f.split(path.sep).join('/')
  }

  // treat the test path as a set of pathparts.
  f = f.split(slashSplit)
  this.debug(this.pattern, 'split', f)

  // just ONE of the pattern sets in this.set needs to match
  // in order for it to be valid.  If negating, then just one
  // match means that we have failed.
  // Either way, return on the first hit.

  var set = this.set
  this.debug(this.pattern, 'set', set)

  // Find the basename of the path by looking for the last non-empty segment
  var filename
  var i
  for (i = f.length - 1; i >= 0; i--) {
    filename = f[i]
    if (filename) break
  }

  for (i = 0; i < set.length; i++) {
    var pattern = set[i]
    var file = f
    if (options.matchBase && pattern.length === 1) {
      file = [filename]
    }
    var hit = this.matchOne(file, pattern, partial)
    if (hit) {
      if (options.flipNegate) return true
      return !this.negate
    }
  }

  // didn't get any hits.  this is success if it's a negative
  // pattern, failure otherwise.
  if (options.flipNegate) return false
  return this.negate
}

// set partial to true to test if, for example,
// "/a/b" matches the start of "/*/b/*/d"
// Partial means, if you run out of file before you run
// out of pattern, then that's fine, as long as all
// the parts match.
Minimatch.prototype.matchOne = function (file, pattern, partial) {
  var options = this.options

  this.debug('matchOne',
    { 'this': this, file: file, pattern: pattern })

  this.debug('matchOne', file.length, pattern.length)

  for (var fi = 0,
      pi = 0,
      fl = file.length,
      pl = pattern.length
      ; (fi < fl) && (pi < pl)
      ; fi++, pi++) {
    this.debug('matchOne loop')
    var p = pattern[pi]
    var f = file[fi]

    this.debug(pattern, p, f)

    // should be impossible.
    // some invalid regexp stuff in the set.
    if (p === false) return false

    if (p === GLOBSTAR) {
      this.debug('GLOBSTAR', [pattern, p, f])

      // "**"
      // a/**/b/**/c would match the following:
      // a/b/x/y/z/c
      // a/x/y/z/b/c
      // a/b/x/b/x/c
      // a/b/c
      // To do this, take the rest of the pattern after
      // the **, and see if it would match the file remainder.
      // If so, return success.
      // If not, the ** "swallows" a segment, and try again.
      // This is recursively awful.
      //
      // a/**/b/**/c matching a/b/x/y/z/c
      // - a matches a
      // - doublestar
      //   - matchOne(b/x/y/z/c, b/**/c)
      //     - b matches b
      //     - doublestar
      //       - matchOne(x/y/z/c, c) -> no
      //       - matchOne(y/z/c, c) -> no
      //       - matchOne(z/c, c) -> no
      //       - matchOne(c, c) yes, hit
      var fr = fi
      var pr = pi + 1
      if (pr === pl) {
        this.debug('** at the end')
        // a ** at the end will just swallow the rest.
        // We have found a match.
        // however, it will not swallow /.x, unless
        // options.dot is set.
        // . and .. are *never* matched by **, for explosively
        // exponential reasons.
        for (; fi < fl; fi++) {
          if (file[fi] === '.' || file[fi] === '..' ||
            (!options.dot && file[fi].charAt(0) === '.')) return false
        }
        return true
      }

      // ok, let's see if we can swallow whatever we can.
      while (fr < fl) {
        var swallowee = file[fr]

        this.debug('\nglobstar while', file, fr, pattern, pr, swallowee)

        // XXX remove this slice.  Just pass the start index.
        if (this.matchOne(file.slice(fr), pattern.slice(pr), partial)) {
          this.debug('globstar found match!', fr, fl, swallowee)
          // found a match.
          return true
        } else {
          // can't swallow "." or ".." ever.
          // can only swallow ".foo" when explicitly asked.
          if (swallowee === '.' || swallowee === '..' ||
            (!options.dot && swallowee.charAt(0) === '.')) {
            this.debug('dot detected!', file, fr, pattern, pr)
            break
          }

          // ** swallows a segment, and continue.
          this.debug('globstar swallow a segment, and continue')
          fr++
        }
      }

      // no match was found.
      // However, in partial mode, we can't say this is necessarily over.
      // If there's more *pattern* left, then
      if (partial) {
        // ran out of file
        this.debug('\n>>> no match, partial?', file, fr, pattern, pr)
        if (fr === fl) return true
      }
      return false
    }

    // something other than **
    // non-magic patterns just have to match exactly
    // patterns with magic have been turned into regexps.
    var hit
    if (typeof p === 'string') {
      if (options.nocase) {
        hit = f.toLowerCase() === p.toLowerCase()
      } else {
        hit = f === p
      }
      this.debug('string match', p, f, hit)
    } else {
      hit = f.match(p)
      this.debug('pattern match', p, f, hit)
    }

    if (!hit) return false
  }

  // Note: ending in / means that we'll get a final ""
  // at the end of the pattern.  This can only match a
  // corresponding "" at the end of the file.
  // If the file ends in /, then it can only match a
  // a pattern that ends in /, unless the pattern just
  // doesn't have any more for it. But, a/b/ should *not*
  // match "a/b/*", even though "" matches against the
  // [^/]*? pattern, except in partial mode, where it might
  // simply not be reached yet.
  // However, a/b/ should still satisfy a/*

  // now either we fell off the end of the pattern, or we're done.
  if (fi === fl && pi === pl) {
    // ran out of pattern and filename at the same time.
    // an exact hit!
    return true
  } else if (fi === fl) {
    // ran out of file, but still had pattern left.
    // this is ok if we're doing the match as part of
    // a glob fs traversal.
    return partial
  } else if (pi === pl) {
    // ran out of pattern, still have file left.
    // this is only acceptable if we're on the very last
    // empty segment of a file with a trailing slash.
    // a/* should match a/b/
    var emptyFileEnd = (fi === fl - 1) && (file[fi] === '')
    return emptyFileEnd
  }

  // should be unreachable.
  throw new Error('wtf?')
}

// replace stuff like \* with *
function globUnescape (s) {
  return s.replace(/\\(.)/g, '$1')
}

function regExpEscape (s) {
  return s.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, '\\$&')
}


/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function posix(path) {
	return path.charAt(0) === '/';
}

function win32(path) {
	// https://github.com/nodejs/node/blob/b3fcc245fb25539909ef1d5eaa01dbf92e168633/lib/path.js#L56
	var splitDeviceRe = /^([a-zA-Z]:|[\\\/]{2}[^\\\/]+[\\\/]+[^\\\/]+)?([\\\/])?([\s\S]*?)$/;
	var result = splitDeviceRe.exec(path);
	var device = result[1] || '';
	var isUnc = Boolean(device && device.charAt(1) !== ':');

	// UNC paths are always absolute
	return Boolean(result[2] || isUnc);
}

module.exports = process.platform === 'win32' ? win32 : posix;
module.exports.posix = posix;
module.exports.win32 = win32;


/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const assign = __webpack_require__(31)

const fs = {}

// Export graceful-fs:
assign(fs, __webpack_require__(14))
// Export extra methods:
assign(fs, __webpack_require__(35))
assign(fs, __webpack_require__(19))
assign(fs, __webpack_require__(3))
assign(fs, __webpack_require__(9))
assign(fs, __webpack_require__(41))
assign(fs, __webpack_require__(45))
assign(fs, __webpack_require__(46))
assign(fs, __webpack_require__(47))
assign(fs, __webpack_require__(48))
assign(fs, __webpack_require__(54))
assign(fs, __webpack_require__(5))

module.exports = fs


/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

// This is adapted from https://github.com/normalize/mz
// Copyright (c) 2014-2016 Jonathan Ong me@jongleberry.com and Contributors
const u = __webpack_require__(2).fromCallback
const fs = __webpack_require__(1)

const api = [
  'access',
  'appendFile',
  'chmod',
  'chown',
  'close',
  'copyFile',
  'fchmod',
  'fchown',
  'fdatasync',
  'fstat',
  'fsync',
  'ftruncate',
  'futimes',
  'lchown',
  'link',
  'lstat',
  'mkdir',
  'mkdtemp',
  'open',
  'readFile',
  'readdir',
  'readlink',
  'realpath',
  'rename',
  'rmdir',
  'stat',
  'symlink',
  'truncate',
  'unlink',
  'utimes',
  'writeFile'
].filter(key => {
  // Some commands are not available on some systems. Ex:
  // fs.copyFile was added in Node.js v8.5.0
  // fs.mkdtemp was added in Node.js v5.10.0
  // fs.lchown is not available on at least some Linux
  return typeof fs[key] === 'function'
})

// Export all keys:
Object.keys(fs).forEach(key => {
  exports[key] = fs[key]
})

// Universalify async methods:
api.forEach(method => {
  exports[method] = u(fs[method])
})

// We differ from mz/fs in that we still ship the old, broken, fs.exists()
// since we are a drop-in replacement for the native module
exports.exists = function (filename, callback) {
  if (typeof callback === 'function') {
    return fs.exists(filename, callback)
  }
  return new Promise(resolve => {
    return fs.exists(filename, resolve)
  })
}

// fs.read() & fs.write need special treatment due to multiple callback args

exports.read = function (fd, buffer, offset, length, position, callback) {
  if (typeof callback === 'function') {
    return fs.read(fd, buffer, offset, length, position, callback)
  }
  return new Promise((resolve, reject) => {
    fs.read(fd, buffer, offset, length, position, (err, bytesRead, buffer) => {
      if (err) return reject(err)
      resolve({ bytesRead, buffer })
    })
  })
}

// Function signature can be
// fs.write(fd, buffer[, offset[, length[, position]]], callback)
// OR
// fs.write(fd, string[, position[, encoding]], callback)
// so we need to handle both cases
exports.write = function (fd, buffer, a, b, c, callback) {
  if (typeof arguments[arguments.length - 1] === 'function') {
    return fs.write(fd, buffer, a, b, c, callback)
  }

  // Check for old, depricated fs.write(fd, string[, position[, encoding]], callback)
  if (typeof buffer === 'string') {
    return new Promise((resolve, reject) => {
      fs.write(fd, buffer, a, b, (err, bytesWritten, buffer) => {
        if (err) return reject(err)
        resolve({ bytesWritten, buffer })
      })
    })
  }

  return new Promise((resolve, reject) => {
    fs.write(fd, buffer, a, b, c, (err, bytesWritten, buffer) => {
      if (err) return reject(err)
      resolve({ bytesWritten, buffer })
    })
  })
}


/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var fs = __webpack_require__(4)

module.exports = clone(fs)

function clone (obj) {
  if (obj === null || typeof obj !== 'object')
    return obj

  if (obj instanceof Object)
    var copy = { __proto__: obj.__proto__ }
  else
    var copy = Object.create(null)

  Object.getOwnPropertyNames(obj).forEach(function (key) {
    Object.defineProperty(copy, key, Object.getOwnPropertyDescriptor(obj, key))
  })

  return copy
}


/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const mkdirp = __webpack_require__(3).mkdirs
const pathExists = __webpack_require__(5).pathExists
const utimes = __webpack_require__(18).utimesMillis

const notExist = Symbol('notExist')
const existsReg = Symbol('existsReg')

function copy (src, dest, opts, cb) {
  if (typeof opts === 'function' && !cb) {
    cb = opts
    opts = {}
  } else if (typeof opts === 'function') {
    opts = {filter: opts}
  }

  cb = cb || function () {}
  opts = opts || {}

  opts.clobber = 'clobber' in opts ? !!opts.clobber : true // default to true for now
  opts.overwrite = 'overwrite' in opts ? !!opts.overwrite : opts.clobber // overwrite falls back to clobber

  // Warn about using preserveTimestamps on 32-bit node
  if (opts.preserveTimestamps && process.arch === 'ia32') {
    console.warn(`fs-extra: Using the preserveTimestamps option in 32-bit node is not recommended;\n
    see https://github.com/jprichardson/node-fs-extra/issues/269`)
  }

  src = path.resolve(src)
  dest = path.resolve(dest)

  // don't allow src and dest to be the same
  if (src === dest) return cb(new Error('Source and destination must not be the same.'))

  if (opts.filter) return handleFilter(checkParentDir, src, dest, opts, cb)
  return checkParentDir(src, dest, opts, cb)
}

function checkParentDir (src, dest, opts, cb) {
  const destParent = path.dirname(dest)
  pathExists(destParent, (err, dirExists) => {
    if (err) return cb(err)
    if (dirExists) return startCopy(src, dest, opts, cb)
    mkdirp(destParent, err => {
      if (err) return cb(err)
      return startCopy(src, dest, opts, cb)
    })
  })
}

function startCopy (src, dest, opts, cb) {
  if (opts.filter) return handleFilter(getStats, src, dest, opts, cb)
  return getStats(src, dest, opts, cb)
}

function handleFilter (onInclude, src, dest, opts, cb) {
  Promise.resolve(opts.filter(src, dest))
    .then(include => {
      if (include) return onInclude(src, dest, opts, cb)
      return cb()
    }, error => cb(error))
}

function getStats (src, dest, opts, cb) {
  const stat = opts.dereference ? fs.stat : fs.lstat
  stat(src, (err, st) => {
    if (err) return cb(err)

    if (st.isDirectory()) return onDir(st, src, dest, opts, cb)
    else if (st.isFile() ||
             st.isCharacterDevice() ||
             st.isBlockDevice()) return onFile(st, src, dest, opts, cb)
    else if (st.isSymbolicLink()) return onLink(src, dest, opts, cb)
  })
}

function onFile (srcStat, src, dest, opts, cb) {
  checkDest(dest, (err, resolvedPath) => {
    if (err) return cb(err)
    if (resolvedPath === notExist) {
      return copyFile(srcStat, src, dest, opts, cb)
    } else if (resolvedPath === existsReg) {
      return mayCopyFile(srcStat, src, dest, opts, cb)
    } else {
      if (src === resolvedPath) return cb()
      return mayCopyFile(srcStat, src, dest, opts, cb)
    }
  })
}

function mayCopyFile (srcStat, src, dest, opts, cb) {
  if (opts.overwrite) {
    fs.unlink(dest, err => {
      if (err) return cb(err)
      return copyFile(srcStat, src, dest, opts, cb)
    })
  } else if (opts.errorOnExist) {
    return cb(new Error(`'${dest}' already exists`))
  } else return cb()
}

function copyFile (srcStat, src, dest, opts, cb) {
  if (typeof fs.copyFile === 'function') {
    return fs.copyFile(src, dest, err => {
      if (err) return cb(err)
      return setDestModeAndTimestamps(srcStat, dest, opts, cb)
    })
  }
  return copyFileFallback(srcStat, src, dest, opts, cb)
}

function copyFileFallback (srcStat, src, dest, opts, cb) {
  const rs = fs.createReadStream(src)
  rs.on('error', err => cb(err))
    .once('open', () => {
      const ws = fs.createWriteStream(dest, { mode: srcStat.mode })
      ws.on('error', err => cb(err))
        .on('open', () => rs.pipe(ws))
        .once('close', () => setDestModeAndTimestamps(srcStat, dest, opts, cb))
    })
}

function setDestModeAndTimestamps (srcStat, dest, opts, cb) {
  fs.chmod(dest, srcStat.mode, err => {
    if (err) return cb(err)
    if (opts.preserveTimestamps) {
      return utimes(dest, srcStat.atime, srcStat.mtime, cb)
    }
    return cb()
  })
}

function onDir (srcStat, src, dest, opts, cb) {
  checkDest(dest, (err, resolvedPath) => {
    if (err) return cb(err)
    if (resolvedPath === notExist) {
      if (isSrcSubdir(src, dest)) {
        return cb(new Error(`Cannot copy '${src}' to a subdirectory of itself, '${dest}'.`))
      }
      return mkDirAndCopy(srcStat, src, dest, opts, cb)
    } else if (resolvedPath === existsReg) {
      if (isSrcSubdir(src, dest)) {
        return cb(new Error(`Cannot copy '${src}' to a subdirectory of itself, '${dest}'.`))
      }
      return mayCopyDir(src, dest, opts, cb)
    } else {
      if (src === resolvedPath) return cb()
      return copyDir(src, dest, opts, cb)
    }
  })
}

function mayCopyDir (src, dest, opts, cb) {
  fs.stat(dest, (err, st) => {
    if (err) return cb(err)
    if (!st.isDirectory()) {
      return cb(new Error(`Cannot overwrite non-directory '${dest}' with directory '${src}'.`))
    }
    return copyDir(src, dest, opts, cb)
  })
}

function mkDirAndCopy (srcStat, src, dest, opts, cb) {
  fs.mkdir(dest, srcStat.mode, err => {
    if (err) return cb(err)
    fs.chmod(dest, srcStat.mode, err => {
      if (err) return cb(err)
      return copyDir(src, dest, opts, cb)
    })
  })
}

function copyDir (src, dest, opts, cb) {
  fs.readdir(src, (err, items) => {
    if (err) return cb(err)
    return copyDirItems(items, src, dest, opts, cb)
  })
}

function copyDirItems (items, src, dest, opts, cb) {
  const item = items.pop()
  if (!item) return cb()
  startCopy(path.join(src, item), path.join(dest, item), opts, err => {
    if (err) return cb(err)
    return copyDirItems(items, src, dest, opts, cb)
  })
}

function onLink (src, dest, opts, cb) {
  fs.readlink(src, (err, resolvedSrcPath) => {
    if (err) return cb(err)

    if (opts.dereference) {
      resolvedSrcPath = path.resolve(process.cwd(), resolvedSrcPath)
    }

    checkDest(dest, (err, resolvedDestPath) => {
      if (err) return cb(err)

      if (resolvedDestPath === notExist || resolvedDestPath === existsReg) {
        // if dest already exists, fs throws error anyway,
        // so no need to guard against it here.
        return fs.symlink(resolvedSrcPath, dest, cb)
      } else {
        if (opts.dereference) {
          resolvedDestPath = path.resolve(process.cwd(), resolvedDestPath)
        }
        if (resolvedDestPath === resolvedSrcPath) return cb()

        // prevent copy if src is a subdir of dest since unlinking
        // dest in this case would result in removing src contents
        // and therefore a broken symlink would be created.
        fs.stat(dest, (err, st) => {
          if (err) return cb(err)
          if (st.isDirectory() && isSrcSubdir(resolvedDestPath, resolvedSrcPath)) {
            return cb(new Error(`Cannot overwrite '${resolvedDestPath}' with '${resolvedSrcPath}'.`))
          }
          return copyLink(resolvedSrcPath, dest, cb)
        })
      }
    })
  })
}

function copyLink (resolvedSrcPath, dest, cb) {
  fs.unlink(dest, err => {
    if (err) return cb(err)
    return fs.symlink(resolvedSrcPath, dest, cb)
  })
}

// check if dest exists and/or is a symlink
function checkDest (dest, cb) {
  fs.readlink(dest, (err, resolvedPath) => {
    if (err) {
      if (err.code === 'ENOENT') return cb(null, notExist)

      // dest exists and is a regular file or directory, Windows may throw UNKNOWN error.
      if (err.code === 'EINVAL' || err.code === 'UNKNOWN') return cb(null, existsReg)

      return cb(err)
    }
    return cb(null, resolvedPath) // dest exists and is a symlink
  })
}

// return true if dest is a subdir of src, otherwise false.
// extract dest base dir and check if that is the same as src basename
function isSrcSubdir (src, dest) {
  const baseDir = dest.split(path.dirname(src) + path.sep)[1]
  if (baseDir) {
    const destBasename = baseDir.split(path.sep)[0]
    if (destBasename) {
      return src !== dest && dest.indexOf(src) > -1 && destBasename === path.basename(src)
    }
    return false
  }
  return false
}

module.exports = copy


/***/ }),
/* 17 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const path = __webpack_require__(0)

// get drive on windows
function getRootPath (p) {
  p = path.normalize(path.resolve(p)).split(path.sep)
  if (p.length > 0) return p[0]
  return null
}

// http://stackoverflow.com/a/62888/10333 contains more accurate
// TODO: expand to include the rest
const INVALID_PATH_CHARS = /[<>:"|?*]/

function invalidWin32Path (p) {
  const rp = getRootPath(p)
  p = p.replace(rp, '')
  return INVALID_PATH_CHARS.test(p)
}

module.exports = {
  getRootPath,
  invalidWin32Path
}


/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const os = __webpack_require__(38)
const path = __webpack_require__(0)

// HFS, ext{2,3}, FAT do not, Node.js v0.10 does not
function hasMillisResSync () {
  let tmpfile = path.join('millis-test-sync' + Date.now().toString() + Math.random().toString().slice(2))
  tmpfile = path.join(os.tmpdir(), tmpfile)

  // 550 millis past UNIX epoch
  const d = new Date(1435410243862)
  fs.writeFileSync(tmpfile, 'https://github.com/jprichardson/node-fs-extra/pull/141')
  const fd = fs.openSync(tmpfile, 'r+')
  fs.futimesSync(fd, d, d)
  fs.closeSync(fd)
  return fs.statSync(tmpfile).mtime > 1435410243000
}

function hasMillisRes (callback) {
  let tmpfile = path.join('millis-test' + Date.now().toString() + Math.random().toString().slice(2))
  tmpfile = path.join(os.tmpdir(), tmpfile)

  // 550 millis past UNIX epoch
  const d = new Date(1435410243862)
  fs.writeFile(tmpfile, 'https://github.com/jprichardson/node-fs-extra/pull/141', err => {
    if (err) return callback(err)
    fs.open(tmpfile, 'r+', (err, fd) => {
      if (err) return callback(err)
      fs.futimes(fd, d, d, err => {
        if (err) return callback(err)
        fs.close(fd, err => {
          if (err) return callback(err)
          fs.stat(tmpfile, (err, stats) => {
            if (err) return callback(err)
            callback(null, stats.mtime > 1435410243000)
          })
        })
      })
    })
  })
}

function timeRemoveMillis (timestamp) {
  if (typeof timestamp === 'number') {
    return Math.floor(timestamp / 1000) * 1000
  } else if (timestamp instanceof Date) {
    return new Date(Math.floor(timestamp.getTime() / 1000) * 1000)
  } else {
    throw new Error('fs-extra: timeRemoveMillis() unknown parameter type')
  }
}

function utimesMillis (path, atime, mtime, callback) {
  // if (!HAS_MILLIS_RES) return fs.utimes(path, atime, mtime, callback)
  fs.open(path, 'r+', (err, fd) => {
    if (err) return callback(err)
    fs.futimes(fd, atime, mtime, futimesErr => {
      fs.close(fd, closeErr => {
        if (callback) callback(futimesErr || closeErr)
      })
    })
  })
}

function utimesMillisSync (path, atime, mtime) {
  const fd = fs.openSync(path, 'r+')
  fs.futimesSync(fd, atime, mtime)
  return fs.closeSync(fd)
}

module.exports = {
  hasMillisRes,
  hasMillisResSync,
  timeRemoveMillis,
  utimesMillis,
  utimesMillisSync
}


/***/ }),
/* 19 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = {
  copySync: __webpack_require__(39)
}


/***/ }),
/* 20 */
/***/ (function(module, exports) {

/* eslint-disable node/no-deprecated-api */
module.exports = function (size) {
  if (typeof Buffer.allocUnsafe === 'function') {
    try {
      return Buffer.allocUnsafe(size)
    } catch (e) {
      return new Buffer(size)
    }
  }
  return new Buffer(size)
}


/***/ }),
/* 21 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
var ClientError = /** @class */ (function (_super) {
    __extends(ClientError, _super);
    function ClientError(response, request) {
        var _this = this;
        var message = ClientError.extractMessage(response) + ": " + JSON.stringify({ response: response, request: request });
        _this = _super.call(this, message) || this;
        _this.response = response;
        _this.request = request;
        // this is needed as Safari doesn't support .captureStackTrace
        /* tslint:disable-next-line */
        if (typeof Error.captureStackTrace === 'function') {
            Error.captureStackTrace(_this, ClientError);
        }
        return _this;
    }
    ClientError.extractMessage = function (response) {
        try {
            return response.errors[0].message;
        }
        catch (e) {
            return "GraphQL Error (Code: " + response.status + ")";
        }
    };
    return ClientError;
}(Error));
exports.ClientError = ClientError;
//# sourceMappingURL=types.js.map

/***/ }),
/* 22 */
/***/ (function(module, exports) {

module.exports = require("http");

/***/ }),
/* 23 */
/***/ (function(module, exports) {

module.exports = require("url");

/***/ }),
/* 24 */
/***/ (function(module, exports, __webpack_require__) {

// Approach:
//
// 1. Get the minimatch set
// 2. For each pattern in the set, PROCESS(pattern, false)
// 3. Store matches per-set, then uniq them
//
// PROCESS(pattern, inGlobStar)
// Get the first [n] items from pattern that are all strings
// Join these together.  This is PREFIX.
//   If there is no more remaining, then stat(PREFIX) and
//   add to matches if it succeeds.  END.
//
// If inGlobStar and PREFIX is symlink and points to dir
//   set ENTRIES = []
// else readdir(PREFIX) as ENTRIES
//   If fail, END
//
// with ENTRIES
//   If pattern[n] is GLOBSTAR
//     // handle the case where the globstar match is empty
//     // by pruning it out, and testing the resulting pattern
//     PROCESS(pattern[0..n] + pattern[n+1 .. $], false)
//     // handle other cases.
//     for ENTRY in ENTRIES (not dotfiles)
//       // attach globstar + tail onto the entry
//       // Mark that this entry is a globstar match
//       PROCESS(pattern[0..n] + ENTRY + pattern[n .. $], true)
//
//   else // not globstar
//     for ENTRY in ENTRIES (not dotfiles, unless pattern[n] is dot)
//       Test ENTRY against pattern[n]
//       If fails, continue
//       If passes, PROCESS(pattern[0..n] + item + pattern[n+1 .. $])
//
// Caveat:
//   Cache all stats and readdirs results to minimize syscall.  Since all
//   we ever care about is existence and directory-ness, we can just keep
//   `true` for files, and [children,...] for directories, or `false` for
//   things that don't exist.

module.exports = glob

var fs = __webpack_require__(4)
var rp = __webpack_require__(25)
var minimatch = __webpack_require__(11)
var Minimatch = minimatch.Minimatch
var inherits = __webpack_require__(69)
var EE = __webpack_require__(71).EventEmitter
var path = __webpack_require__(0)
var assert = __webpack_require__(8)
var isAbsolute = __webpack_require__(12)
var globSync = __webpack_require__(72)
var common = __webpack_require__(26)
var alphasort = common.alphasort
var alphasorti = common.alphasorti
var setopts = common.setopts
var ownProp = common.ownProp
var inflight = __webpack_require__(73)
var util = __webpack_require__(7)
var childrenIgnored = common.childrenIgnored
var isIgnored = common.isIgnored

var once = __webpack_require__(28)

function glob (pattern, options, cb) {
  if (typeof options === 'function') cb = options, options = {}
  if (!options) options = {}

  if (options.sync) {
    if (cb)
      throw new TypeError('callback provided to sync glob')
    return globSync(pattern, options)
  }

  return new Glob(pattern, options, cb)
}

glob.sync = globSync
var GlobSync = glob.GlobSync = globSync.GlobSync

// old api surface
glob.glob = glob

function extend (origin, add) {
  if (add === null || typeof add !== 'object') {
    return origin
  }

  var keys = Object.keys(add)
  var i = keys.length
  while (i--) {
    origin[keys[i]] = add[keys[i]]
  }
  return origin
}

glob.hasMagic = function (pattern, options_) {
  var options = extend({}, options_)
  options.noprocess = true

  var g = new Glob(pattern, options)
  var set = g.minimatch.set

  if (!pattern)
    return false

  if (set.length > 1)
    return true

  for (var j = 0; j < set[0].length; j++) {
    if (typeof set[0][j] !== 'string')
      return true
  }

  return false
}

glob.Glob = Glob
inherits(Glob, EE)
function Glob (pattern, options, cb) {
  if (typeof options === 'function') {
    cb = options
    options = null
  }

  if (options && options.sync) {
    if (cb)
      throw new TypeError('callback provided to sync glob')
    return new GlobSync(pattern, options)
  }

  if (!(this instanceof Glob))
    return new Glob(pattern, options, cb)

  setopts(this, pattern, options)
  this._didRealPath = false

  // process each pattern in the minimatch set
  var n = this.minimatch.set.length

  // The matches are stored as {<filename>: true,...} so that
  // duplicates are automagically pruned.
  // Later, we do an Object.keys() on these.
  // Keep them as a list so we can fill in when nonull is set.
  this.matches = new Array(n)

  if (typeof cb === 'function') {
    cb = once(cb)
    this.on('error', cb)
    this.on('end', function (matches) {
      cb(null, matches)
    })
  }

  var self = this
  this._processing = 0

  this._emitQueue = []
  this._processQueue = []
  this.paused = false

  if (this.noprocess)
    return this

  if (n === 0)
    return done()

  var sync = true
  for (var i = 0; i < n; i ++) {
    this._process(this.minimatch.set[i], i, false, done)
  }
  sync = false

  function done () {
    --self._processing
    if (self._processing <= 0) {
      if (sync) {
        process.nextTick(function () {
          self._finish()
        })
      } else {
        self._finish()
      }
    }
  }
}

Glob.prototype._finish = function () {
  assert(this instanceof Glob)
  if (this.aborted)
    return

  if (this.realpath && !this._didRealpath)
    return this._realpath()

  common.finish(this)
  this.emit('end', this.found)
}

Glob.prototype._realpath = function () {
  if (this._didRealpath)
    return

  this._didRealpath = true

  var n = this.matches.length
  if (n === 0)
    return this._finish()

  var self = this
  for (var i = 0; i < this.matches.length; i++)
    this._realpathSet(i, next)

  function next () {
    if (--n === 0)
      self._finish()
  }
}

Glob.prototype._realpathSet = function (index, cb) {
  var matchset = this.matches[index]
  if (!matchset)
    return cb()

  var found = Object.keys(matchset)
  var self = this
  var n = found.length

  if (n === 0)
    return cb()

  var set = this.matches[index] = Object.create(null)
  found.forEach(function (p, i) {
    // If there's a problem with the stat, then it means that
    // one or more of the links in the realpath couldn't be
    // resolved.  just return the abs value in that case.
    p = self._makeAbs(p)
    rp.realpath(p, self.realpathCache, function (er, real) {
      if (!er)
        set[real] = true
      else if (er.syscall === 'stat')
        set[p] = true
      else
        self.emit('error', er) // srsly wtf right here

      if (--n === 0) {
        self.matches[index] = set
        cb()
      }
    })
  })
}

Glob.prototype._mark = function (p) {
  return common.mark(this, p)
}

Glob.prototype._makeAbs = function (f) {
  return common.makeAbs(this, f)
}

Glob.prototype.abort = function () {
  this.aborted = true
  this.emit('abort')
}

Glob.prototype.pause = function () {
  if (!this.paused) {
    this.paused = true
    this.emit('pause')
  }
}

Glob.prototype.resume = function () {
  if (this.paused) {
    this.emit('resume')
    this.paused = false
    if (this._emitQueue.length) {
      var eq = this._emitQueue.slice(0)
      this._emitQueue.length = 0
      for (var i = 0; i < eq.length; i ++) {
        var e = eq[i]
        this._emitMatch(e[0], e[1])
      }
    }
    if (this._processQueue.length) {
      var pq = this._processQueue.slice(0)
      this._processQueue.length = 0
      for (var i = 0; i < pq.length; i ++) {
        var p = pq[i]
        this._processing--
        this._process(p[0], p[1], p[2], p[3])
      }
    }
  }
}

Glob.prototype._process = function (pattern, index, inGlobStar, cb) {
  assert(this instanceof Glob)
  assert(typeof cb === 'function')

  if (this.aborted)
    return

  this._processing++
  if (this.paused) {
    this._processQueue.push([pattern, index, inGlobStar, cb])
    return
  }

  //console.error('PROCESS %d', this._processing, pattern)

  // Get the first [n] parts of pattern that are all strings.
  var n = 0
  while (typeof pattern[n] === 'string') {
    n ++
  }
  // now n is the index of the first one that is *not* a string.

  // see if there's anything else
  var prefix
  switch (n) {
    // if not, then this is rather simple
    case pattern.length:
      this._processSimple(pattern.join('/'), index, cb)
      return

    case 0:
      // pattern *starts* with some non-trivial item.
      // going to readdir(cwd), but not include the prefix in matches.
      prefix = null
      break

    default:
      // pattern has some string bits in the front.
      // whatever it starts with, whether that's 'absolute' like /foo/bar,
      // or 'relative' like '../baz'
      prefix = pattern.slice(0, n).join('/')
      break
  }

  var remain = pattern.slice(n)

  // get the list of entries.
  var read
  if (prefix === null)
    read = '.'
  else if (isAbsolute(prefix) || isAbsolute(pattern.join('/'))) {
    if (!prefix || !isAbsolute(prefix))
      prefix = '/' + prefix
    read = prefix
  } else
    read = prefix

  var abs = this._makeAbs(read)

  //if ignored, skip _processing
  if (childrenIgnored(this, read))
    return cb()

  var isGlobStar = remain[0] === minimatch.GLOBSTAR
  if (isGlobStar)
    this._processGlobStar(prefix, read, abs, remain, index, inGlobStar, cb)
  else
    this._processReaddir(prefix, read, abs, remain, index, inGlobStar, cb)
}

Glob.prototype._processReaddir = function (prefix, read, abs, remain, index, inGlobStar, cb) {
  var self = this
  this._readdir(abs, inGlobStar, function (er, entries) {
    return self._processReaddir2(prefix, read, abs, remain, index, inGlobStar, entries, cb)
  })
}

Glob.prototype._processReaddir2 = function (prefix, read, abs, remain, index, inGlobStar, entries, cb) {

  // if the abs isn't a dir, then nothing can match!
  if (!entries)
    return cb()

  // It will only match dot entries if it starts with a dot, or if
  // dot is set.  Stuff like @(.foo|.bar) isn't allowed.
  var pn = remain[0]
  var negate = !!this.minimatch.negate
  var rawGlob = pn._glob
  var dotOk = this.dot || rawGlob.charAt(0) === '.'

  var matchedEntries = []
  for (var i = 0; i < entries.length; i++) {
    var e = entries[i]
    if (e.charAt(0) !== '.' || dotOk) {
      var m
      if (negate && !prefix) {
        m = !e.match(pn)
      } else {
        m = e.match(pn)
      }
      if (m)
        matchedEntries.push(e)
    }
  }

  //console.error('prd2', prefix, entries, remain[0]._glob, matchedEntries)

  var len = matchedEntries.length
  // If there are no matched entries, then nothing matches.
  if (len === 0)
    return cb()

  // if this is the last remaining pattern bit, then no need for
  // an additional stat *unless* the user has specified mark or
  // stat explicitly.  We know they exist, since readdir returned
  // them.

  if (remain.length === 1 && !this.mark && !this.stat) {
    if (!this.matches[index])
      this.matches[index] = Object.create(null)

    for (var i = 0; i < len; i ++) {
      var e = matchedEntries[i]
      if (prefix) {
        if (prefix !== '/')
          e = prefix + '/' + e
        else
          e = prefix + e
      }

      if (e.charAt(0) === '/' && !this.nomount) {
        e = path.join(this.root, e)
      }
      this._emitMatch(index, e)
    }
    // This was the last one, and no stats were needed
    return cb()
  }

  // now test all matched entries as stand-ins for that part
  // of the pattern.
  remain.shift()
  for (var i = 0; i < len; i ++) {
    var e = matchedEntries[i]
    var newPattern
    if (prefix) {
      if (prefix !== '/')
        e = prefix + '/' + e
      else
        e = prefix + e
    }
    this._process([e].concat(remain), index, inGlobStar, cb)
  }
  cb()
}

Glob.prototype._emitMatch = function (index, e) {
  if (this.aborted)
    return

  if (isIgnored(this, e))
    return

  if (this.paused) {
    this._emitQueue.push([index, e])
    return
  }

  var abs = isAbsolute(e) ? e : this._makeAbs(e)

  if (this.mark)
    e = this._mark(e)

  if (this.absolute)
    e = abs

  if (this.matches[index][e])
    return

  if (this.nodir) {
    var c = this.cache[abs]
    if (c === 'DIR' || Array.isArray(c))
      return
  }

  this.matches[index][e] = true

  var st = this.statCache[abs]
  if (st)
    this.emit('stat', e, st)

  this.emit('match', e)
}

Glob.prototype._readdirInGlobStar = function (abs, cb) {
  if (this.aborted)
    return

  // follow all symlinked directories forever
  // just proceed as if this is a non-globstar situation
  if (this.follow)
    return this._readdir(abs, false, cb)

  var lstatkey = 'lstat\0' + abs
  var self = this
  var lstatcb = inflight(lstatkey, lstatcb_)

  if (lstatcb)
    fs.lstat(abs, lstatcb)

  function lstatcb_ (er, lstat) {
    if (er && er.code === 'ENOENT')
      return cb()

    var isSym = lstat && lstat.isSymbolicLink()
    self.symlinks[abs] = isSym

    // If it's not a symlink or a dir, then it's definitely a regular file.
    // don't bother doing a readdir in that case.
    if (!isSym && lstat && !lstat.isDirectory()) {
      self.cache[abs] = 'FILE'
      cb()
    } else
      self._readdir(abs, false, cb)
  }
}

Glob.prototype._readdir = function (abs, inGlobStar, cb) {
  if (this.aborted)
    return

  cb = inflight('readdir\0'+abs+'\0'+inGlobStar, cb)
  if (!cb)
    return

  //console.error('RD %j %j', +inGlobStar, abs)
  if (inGlobStar && !ownProp(this.symlinks, abs))
    return this._readdirInGlobStar(abs, cb)

  if (ownProp(this.cache, abs)) {
    var c = this.cache[abs]
    if (!c || c === 'FILE')
      return cb()

    if (Array.isArray(c))
      return cb(null, c)
  }

  var self = this
  fs.readdir(abs, readdirCb(this, abs, cb))
}

function readdirCb (self, abs, cb) {
  return function (er, entries) {
    if (er)
      self._readdirError(abs, er, cb)
    else
      self._readdirEntries(abs, entries, cb)
  }
}

Glob.prototype._readdirEntries = function (abs, entries, cb) {
  if (this.aborted)
    return

  // if we haven't asked to stat everything, then just
  // assume that everything in there exists, so we can avoid
  // having to stat it a second time.
  if (!this.mark && !this.stat) {
    for (var i = 0; i < entries.length; i ++) {
      var e = entries[i]
      if (abs === '/')
        e = abs + e
      else
        e = abs + '/' + e
      this.cache[e] = true
    }
  }

  this.cache[abs] = entries
  return cb(null, entries)
}

Glob.prototype._readdirError = function (f, er, cb) {
  if (this.aborted)
    return

  // handle errors, and cache the information
  switch (er.code) {
    case 'ENOTSUP': // https://github.com/isaacs/node-glob/issues/205
    case 'ENOTDIR': // totally normal. means it *does* exist.
      var abs = this._makeAbs(f)
      this.cache[abs] = 'FILE'
      if (abs === this.cwdAbs) {
        var error = new Error(er.code + ' invalid cwd ' + this.cwd)
        error.path = this.cwd
        error.code = er.code
        this.emit('error', error)
        this.abort()
      }
      break

    case 'ENOENT': // not terribly unusual
    case 'ELOOP':
    case 'ENAMETOOLONG':
    case 'UNKNOWN':
      this.cache[this._makeAbs(f)] = false
      break

    default: // some unusual error.  Treat as failure.
      this.cache[this._makeAbs(f)] = false
      if (this.strict) {
        this.emit('error', er)
        // If the error is handled, then we abort
        // if not, we threw out of here
        this.abort()
      }
      if (!this.silent)
        console.error('glob error', er)
      break
  }

  return cb()
}

Glob.prototype._processGlobStar = function (prefix, read, abs, remain, index, inGlobStar, cb) {
  var self = this
  this._readdir(abs, inGlobStar, function (er, entries) {
    self._processGlobStar2(prefix, read, abs, remain, index, inGlobStar, entries, cb)
  })
}


Glob.prototype._processGlobStar2 = function (prefix, read, abs, remain, index, inGlobStar, entries, cb) {
  //console.error('pgs2', prefix, remain[0], entries)

  // no entries means not a dir, so it can never have matches
  // foo.txt/** doesn't match foo.txt
  if (!entries)
    return cb()

  // test without the globstar, and with every child both below
  // and replacing the globstar.
  var remainWithoutGlobStar = remain.slice(1)
  var gspref = prefix ? [ prefix ] : []
  var noGlobStar = gspref.concat(remainWithoutGlobStar)

  // the noGlobStar pattern exits the inGlobStar state
  this._process(noGlobStar, index, false, cb)

  var isSym = this.symlinks[abs]
  var len = entries.length

  // If it's a symlink, and we're in a globstar, then stop
  if (isSym && inGlobStar)
    return cb()

  for (var i = 0; i < len; i++) {
    var e = entries[i]
    if (e.charAt(0) === '.' && !this.dot)
      continue

    // these two cases enter the inGlobStar state
    var instead = gspref.concat(entries[i], remainWithoutGlobStar)
    this._process(instead, index, true, cb)

    var below = gspref.concat(entries[i], remain)
    this._process(below, index, true, cb)
  }

  cb()
}

Glob.prototype._processSimple = function (prefix, index, cb) {
  // XXX review this.  Shouldn't it be doing the mounting etc
  // before doing stat?  kinda weird?
  var self = this
  this._stat(prefix, function (er, exists) {
    self._processSimple2(prefix, index, er, exists, cb)
  })
}
Glob.prototype._processSimple2 = function (prefix, index, er, exists, cb) {

  //console.error('ps2', prefix, exists)

  if (!this.matches[index])
    this.matches[index] = Object.create(null)

  // If it doesn't exist, then just mark the lack of results
  if (!exists)
    return cb()

  if (prefix && isAbsolute(prefix) && !this.nomount) {
    var trail = /[\/\\]$/.test(prefix)
    if (prefix.charAt(0) === '/') {
      prefix = path.join(this.root, prefix)
    } else {
      prefix = path.resolve(this.root, prefix)
      if (trail)
        prefix += '/'
    }
  }

  if (process.platform === 'win32')
    prefix = prefix.replace(/\\/g, '/')

  // Mark this as a match
  this._emitMatch(index, prefix)
  cb()
}

// Returns either 'DIR', 'FILE', or false
Glob.prototype._stat = function (f, cb) {
  var abs = this._makeAbs(f)
  var needDir = f.slice(-1) === '/'

  if (f.length > this.maxLength)
    return cb()

  if (!this.stat && ownProp(this.cache, abs)) {
    var c = this.cache[abs]

    if (Array.isArray(c))
      c = 'DIR'

    // It exists, but maybe not how we need it
    if (!needDir || c === 'DIR')
      return cb(null, c)

    if (needDir && c === 'FILE')
      return cb()

    // otherwise we have to stat, because maybe c=true
    // if we know it exists, but not what it is.
  }

  var exists
  var stat = this.statCache[abs]
  if (stat !== undefined) {
    if (stat === false)
      return cb(null, stat)
    else {
      var type = stat.isDirectory() ? 'DIR' : 'FILE'
      if (needDir && type === 'FILE')
        return cb()
      else
        return cb(null, type, stat)
    }
  }

  var self = this
  var statcb = inflight('stat\0' + abs, lstatcb_)
  if (statcb)
    fs.lstat(abs, statcb)

  function lstatcb_ (er, lstat) {
    if (lstat && lstat.isSymbolicLink()) {
      // If it's a symlink, then treat it as the target, unless
      // the target does not exist, then treat it as a file.
      return fs.stat(abs, function (er, stat) {
        if (er)
          self._stat2(f, abs, null, lstat, cb)
        else
          self._stat2(f, abs, er, stat, cb)
      })
    } else {
      self._stat2(f, abs, er, lstat, cb)
    }
  }
}

Glob.prototype._stat2 = function (f, abs, er, stat, cb) {
  if (er && (er.code === 'ENOENT' || er.code === 'ENOTDIR')) {
    this.statCache[abs] = false
    return cb()
  }

  var needDir = f.slice(-1) === '/'
  this.statCache[abs] = stat

  if (abs.slice(-1) === '/' && stat && !stat.isDirectory())
    return cb(null, false, stat)

  var c = true
  if (stat)
    c = stat.isDirectory() ? 'DIR' : 'FILE'
  this.cache[abs] = this.cache[abs] || c

  if (needDir && c === 'FILE')
    return cb()

  return cb(null, c, stat)
}


/***/ }),
/* 25 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = realpath
realpath.realpath = realpath
realpath.sync = realpathSync
realpath.realpathSync = realpathSync
realpath.monkeypatch = monkeypatch
realpath.unmonkeypatch = unmonkeypatch

var fs = __webpack_require__(4)
var origRealpath = fs.realpath
var origRealpathSync = fs.realpathSync

var version = process.version
var ok = /^v[0-5]\./.test(version)
var old = __webpack_require__(65)

function newError (er) {
  return er && er.syscall === 'realpath' && (
    er.code === 'ELOOP' ||
    er.code === 'ENOMEM' ||
    er.code === 'ENAMETOOLONG'
  )
}

function realpath (p, cache, cb) {
  if (ok) {
    return origRealpath(p, cache, cb)
  }

  if (typeof cache === 'function') {
    cb = cache
    cache = null
  }
  origRealpath(p, cache, function (er, result) {
    if (newError(er)) {
      old.realpath(p, cache, cb)
    } else {
      cb(er, result)
    }
  })
}

function realpathSync (p, cache) {
  if (ok) {
    return origRealpathSync(p, cache)
  }

  try {
    return origRealpathSync(p, cache)
  } catch (er) {
    if (newError(er)) {
      return old.realpathSync(p, cache)
    } else {
      throw er
    }
  }
}

function monkeypatch () {
  fs.realpath = realpath
  fs.realpathSync = realpathSync
}

function unmonkeypatch () {
  fs.realpath = origRealpath
  fs.realpathSync = origRealpathSync
}


/***/ }),
/* 26 */
/***/ (function(module, exports, __webpack_require__) {

exports.alphasort = alphasort
exports.alphasorti = alphasorti
exports.setopts = setopts
exports.ownProp = ownProp
exports.makeAbs = makeAbs
exports.finish = finish
exports.mark = mark
exports.isIgnored = isIgnored
exports.childrenIgnored = childrenIgnored

function ownProp (obj, field) {
  return Object.prototype.hasOwnProperty.call(obj, field)
}

var path = __webpack_require__(0)
var minimatch = __webpack_require__(11)
var isAbsolute = __webpack_require__(12)
var Minimatch = minimatch.Minimatch

function alphasorti (a, b) {
  return a.toLowerCase().localeCompare(b.toLowerCase())
}

function alphasort (a, b) {
  return a.localeCompare(b)
}

function setupIgnores (self, options) {
  self.ignore = options.ignore || []

  if (!Array.isArray(self.ignore))
    self.ignore = [self.ignore]

  if (self.ignore.length) {
    self.ignore = self.ignore.map(ignoreMap)
  }
}

// ignore patterns are always in dot:true mode.
function ignoreMap (pattern) {
  var gmatcher = null
  if (pattern.slice(-3) === '/**') {
    var gpattern = pattern.replace(/(\/\*\*)+$/, '')
    gmatcher = new Minimatch(gpattern, { dot: true })
  }

  return {
    matcher: new Minimatch(pattern, { dot: true }),
    gmatcher: gmatcher
  }
}

function setopts (self, pattern, options) {
  if (!options)
    options = {}

  // base-matching: just use globstar for that.
  if (options.matchBase && -1 === pattern.indexOf("/")) {
    if (options.noglobstar) {
      throw new Error("base matching requires globstar")
    }
    pattern = "**/" + pattern
  }

  self.silent = !!options.silent
  self.pattern = pattern
  self.strict = options.strict !== false
  self.realpath = !!options.realpath
  self.realpathCache = options.realpathCache || Object.create(null)
  self.follow = !!options.follow
  self.dot = !!options.dot
  self.mark = !!options.mark
  self.nodir = !!options.nodir
  if (self.nodir)
    self.mark = true
  self.sync = !!options.sync
  self.nounique = !!options.nounique
  self.nonull = !!options.nonull
  self.nosort = !!options.nosort
  self.nocase = !!options.nocase
  self.stat = !!options.stat
  self.noprocess = !!options.noprocess
  self.absolute = !!options.absolute

  self.maxLength = options.maxLength || Infinity
  self.cache = options.cache || Object.create(null)
  self.statCache = options.statCache || Object.create(null)
  self.symlinks = options.symlinks || Object.create(null)

  setupIgnores(self, options)

  self.changedCwd = false
  var cwd = process.cwd()
  if (!ownProp(options, "cwd"))
    self.cwd = cwd
  else {
    self.cwd = path.resolve(options.cwd)
    self.changedCwd = self.cwd !== cwd
  }

  self.root = options.root || path.resolve(self.cwd, "/")
  self.root = path.resolve(self.root)
  if (process.platform === "win32")
    self.root = self.root.replace(/\\/g, "/")

  // TODO: is an absolute `cwd` supposed to be resolved against `root`?
  // e.g. { cwd: '/test', root: __dirname } === path.join(__dirname, '/test')
  self.cwdAbs = isAbsolute(self.cwd) ? self.cwd : makeAbs(self, self.cwd)
  if (process.platform === "win32")
    self.cwdAbs = self.cwdAbs.replace(/\\/g, "/")
  self.nomount = !!options.nomount

  // disable comments and negation in Minimatch.
  // Note that they are not supported in Glob itself anyway.
  options.nonegate = true
  options.nocomment = true

  self.minimatch = new Minimatch(pattern, options)
  self.options = self.minimatch.options
}

function finish (self) {
  var nou = self.nounique
  var all = nou ? [] : Object.create(null)

  for (var i = 0, l = self.matches.length; i < l; i ++) {
    var matches = self.matches[i]
    if (!matches || Object.keys(matches).length === 0) {
      if (self.nonull) {
        // do like the shell, and spit out the literal glob
        var literal = self.minimatch.globSet[i]
        if (nou)
          all.push(literal)
        else
          all[literal] = true
      }
    } else {
      // had matches
      var m = Object.keys(matches)
      if (nou)
        all.push.apply(all, m)
      else
        m.forEach(function (m) {
          all[m] = true
        })
    }
  }

  if (!nou)
    all = Object.keys(all)

  if (!self.nosort)
    all = all.sort(self.nocase ? alphasorti : alphasort)

  // at *some* point we statted all of these
  if (self.mark) {
    for (var i = 0; i < all.length; i++) {
      all[i] = self._mark(all[i])
    }
    if (self.nodir) {
      all = all.filter(function (e) {
        var notDir = !(/\/$/.test(e))
        var c = self.cache[e] || self.cache[makeAbs(self, e)]
        if (notDir && c)
          notDir = c !== 'DIR' && !Array.isArray(c)
        return notDir
      })
    }
  }

  if (self.ignore.length)
    all = all.filter(function(m) {
      return !isIgnored(self, m)
    })

  self.found = all
}

function mark (self, p) {
  var abs = makeAbs(self, p)
  var c = self.cache[abs]
  var m = p
  if (c) {
    var isDir = c === 'DIR' || Array.isArray(c)
    var slash = p.slice(-1) === '/'

    if (isDir && !slash)
      m += '/'
    else if (!isDir && slash)
      m = m.slice(0, -1)

    if (m !== p) {
      var mabs = makeAbs(self, m)
      self.statCache[mabs] = self.statCache[abs]
      self.cache[mabs] = self.cache[abs]
    }
  }

  return m
}

// lotta situps...
function makeAbs (self, f) {
  var abs = f
  if (f.charAt(0) === '/') {
    abs = path.join(self.root, f)
  } else if (isAbsolute(f) || f === '') {
    abs = f
  } else if (self.changedCwd) {
    abs = path.resolve(self.cwd, f)
  } else {
    abs = path.resolve(f)
  }

  if (process.platform === 'win32')
    abs = abs.replace(/\\/g, '/')

  return abs
}


// Return true, if pattern ends with globstar '**', for the accompanying parent directory.
// Ex:- If node_modules/** is the pattern, add 'node_modules' to ignore list along with it's contents
function isIgnored (self, path) {
  if (!self.ignore.length)
    return false

  return self.ignore.some(function(item) {
    return item.matcher.match(path) || !!(item.gmatcher && item.gmatcher.match(path))
  })
}

function childrenIgnored (self, path) {
  if (!self.ignore.length)
    return false

  return self.ignore.some(function(item) {
    return !!(item.gmatcher && item.gmatcher.match(path))
  })
}


/***/ }),
/* 27 */
/***/ (function(module, exports) {

// Returns a wrapper function that returns a wrapped callback
// The wrapper function should do some stuff, and return a
// presumably different callback function.
// This makes sure that own properties are retained, so that
// decorations and such are not lost along the way.
module.exports = wrappy
function wrappy (fn, cb) {
  if (fn && cb) return wrappy(fn)(cb)

  if (typeof fn !== 'function')
    throw new TypeError('need wrapper function')

  Object.keys(fn).forEach(function (k) {
    wrapper[k] = fn[k]
  })

  return wrapper

  function wrapper() {
    var args = new Array(arguments.length)
    for (var i = 0; i < args.length; i++) {
      args[i] = arguments[i]
    }
    var ret = fn.apply(this, args)
    var cb = args[args.length-1]
    if (typeof ret === 'function' && ret !== cb) {
      Object.keys(cb).forEach(function (k) {
        ret[k] = cb[k]
      })
    }
    return ret
  }
}


/***/ }),
/* 28 */
/***/ (function(module, exports, __webpack_require__) {

var wrappy = __webpack_require__(27)
module.exports = wrappy(once)
module.exports.strict = wrappy(onceStrict)

once.proto = once(function () {
  Object.defineProperty(Function.prototype, 'once', {
    value: function () {
      return once(this)
    },
    configurable: true
  })

  Object.defineProperty(Function.prototype, 'onceStrict', {
    value: function () {
      return onceStrict(this)
    },
    configurable: true
  })
})

function once (fn) {
  var f = function () {
    if (f.called) return f.value
    f.called = true
    return f.value = fn.apply(this, arguments)
  }
  f.called = false
  return f
}

function onceStrict (fn) {
  var f = function () {
    if (f.called)
      throw new Error(f.onceError)
    f.called = true
    return f.value = fn.apply(this, arguments)
  }
  var name = fn.name || 'Function wrapped with `once`'
  f.onceError = name + " shouldn't be called more than once"
  f.called = false
  return f
}


/***/ }),
/* 29 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var Elm = __webpack_require__(30).Elm;
var fs = __webpack_require__(13);
var graphql_request_1 = __webpack_require__(55);
var minimist = __webpack_require__(61);
var formatted_write_1 = __webpack_require__(62);
var introspection_query_1 = __webpack_require__(64);
var glob = __webpack_require__(24);
var path = __webpack_require__(0);
var npmPackageVersion = __webpack_require__(74).version;
var elmPackageVersion = __webpack_require__(75).version;
var usage = "Usage:\n  elm-graphql url # generate files based on the schema at `url` in folder ./src/Api\n  elm-graphql url --base My.Api.Submodule # generate files based on the schema at `url` in folder ./src/My/Api/Submodule\n  elm-graphql url --output path/to/src # generates code within path/to/src/Api\n  elm-graphql url --output path/to/src --base My.Api.Submodule # generates code within path/to/src/My/Api/Submodule\n  elm-graphql url --excludeDeprecated # excludes deprecated enums and fields (they are included by default)\n\n  # Schema file instead of URL\n  elm-graphql --introspection-file path/to/introspection-response.json\n\n  elm-graphql --version # print the current @dillonkearns/elm-graphql version and target elm package version\n  elm-graphql url [--header 'headerKey: header value'...] # you can supply multiple header args";
function isGenerated(path) {
    return (fs
        .readFileSync(path)
        .indexOf("Do not manually edit this file, it was auto-generated by") >= 0);
}
function warnIfContainsNonGenerated(path) {
    var files = glob.sync(path + "/**/*.elm");
    var nonGenerated = files.filter(function (file) { return !isGenerated(file); });
    if (nonGenerated.length > 0) {
        console.log("@dillonkearns/elm-graphql found some files that it did not generate. Please move or delete the following files and run @dillonkearns/elm-graphql again.", nonGenerated);
        process.exit(1);
    }
}
function removeGenerated(path) {
    glob.sync(path + "/**/*.elm").forEach(fs.unlinkSync);
}
var targetComment = "-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql\n-- https://github.com/dillonkearns/elm-graphql\n";
var args = minimist(process.argv.slice(2));
if (args.version) {
    console.log("npm version ", npmPackageVersion);
    console.log("Targeting elm package dillonkearns/elm-graphql@" + elmPackageVersion);
    process.exit(0);
}
var baseArgRegex = /^[A-Z][A-Za-z_]*(\.[A-Z][A-Za-z_]*)*$/;
var baseModuleArg = args.base;
var outputPath = args.output || "./src";
function isValidBaseArg(baseArg) {
    return !!baseArg.match(baseArgRegex);
}
if (baseModuleArg && !isValidBaseArg(baseModuleArg)) {
    console.log("--base was '" + baseModuleArg + "' but must be in format " + baseArgRegex);
    process.exit(1);
}
var excludeDeprecated = args.excludeDeprecated === null || args.excludeDeprecated === undefined
    ? false
    : args.excludeDeprecated;
var headerArg = args.header;
var addHeader = function (object, header) {
    var _a = header.split(":"), headerKey = _a[0], headerValue = _a[1];
    object[headerKey] = headerValue;
    return object;
};
var headers = {};
if (typeof headerArg === "string") {
    addHeader(headers, headerArg);
}
else if (headerArg == undefined) {
}
else {
    headerArg.forEach(function (header) {
        addHeader(headers, header);
    });
}
var baseModule = baseModuleArg ? baseModuleArg.split(".") : ["Api"];
function prependBasePath(suffixPath) {
    return path.join(outputPath, baseModule.join("/"), suffixPath);
}
var graphqlUrl = args._[0];
var introspectionFile = args["introspection-file"];
if (!(graphqlUrl || introspectionFile)) {
    console.log(usage);
    process.exit(0);
}
warnIfContainsNonGenerated(prependBasePath("/"));
var onDataAvailable = function (data) {
    console.log("Generating files...");
    var app = Elm.Main.init({ flags: { data: data, baseModule: baseModule } });
    app.ports.generatedFiles.subscribe(function (generatedFile) {
        removeGenerated(prependBasePath("/"));
        fs.mkdirpSync(prependBasePath("InputObject"));
        fs.mkdirpSync(prependBasePath("Object"));
        fs.mkdirpSync(prependBasePath("Interface"));
        fs.mkdirpSync(prependBasePath("Union"));
        fs.mkdirpSync(prependBasePath("Enum"));
        for (var key in generatedFile) {
            var filePath = path.join(outputPath, key);
            var value = generatedFile[key];
            formatted_write_1.writeFile(filePath, targetComment + value);
        }
        fs.writeFileSync(prependBasePath("elm-graphql-metadata.json"), "{\"targetElmPackageVersion\": \"" + elmPackageVersion + "\", \"generatedByNpmPackageVersion\": \"" + npmPackageVersion + "\"}");
        console.log("Success!");
    });
};
if (introspectionFile) {
    var introspectionFileJson = JSON.parse(fs.readFileSync(introspectionFile).toString());
    onDataAvailable(introspectionFileJson.data || introspectionFileJson);
}
else {
    console.log("Fetching GraphQL schema...");
    new graphql_request_1.GraphQLClient(graphqlUrl, {
        mode: "cors",
        headers: headers
    })
        .request(introspection_query_1.introspectionQuery, { includeDeprecated: !excludeDeprecated })
        .then(function (data) {
        onDataAvailable(data);
    })
        .catch(function (err) {
        console.log(err.response || err);
        process.exit(1);
    });
}


/***/ }),
/* 30 */
/***/ (function(module, exports) {

(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.0/optimize for better performance and smaller assets.');


var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[94m' + string + '\x1b[0m' : string;
}



// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var message = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + message);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = elm$core$Set$toList(x);
		y = elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = elm$core$Dict$toList(x);
		y = elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = elm$core$Dict$toList(x);
		y = elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (!x.$)
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? elm$core$Basics$LT : n ? elm$core$Basics$GT : elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === elm$core$Basics$EQ ? 0 : ord === elm$core$Basics$LT ? -1 : 1;
	}));
});



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return word
		? elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? elm$core$Maybe$Nothing
		: elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? elm$core$Maybe$Just(n) : elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });


// CREATE

var _Regex_never = /.^/;

var _Regex_fromStringWith = F2(function(options, string)
{
	var flags = 'g';
	if (options.multiline) { flags += 'm'; }
	if (options.caseInsensitive) { flags += 'i'; }

	try
	{
		return elm$core$Maybe$Just(new RegExp(string, flags));
	}
	catch(error)
	{
		return elm$core$Maybe$Nothing;
	}
});


// USE

var _Regex_contains = F2(function(re, string)
{
	return string.match(re) !== null;
});


var _Regex_findAtMost = F3(function(n, re, str)
{
	var out = [];
	var number = 0;
	var string = str;
	var lastIndex = re.lastIndex;
	var prevLastIndex = -1;
	var result;
	while (number++ < n && (result = re.exec(string)))
	{
		if (prevLastIndex == re.lastIndex) break;
		var i = result.length - 1;
		var subs = new Array(i);
		while (i > 0)
		{
			var submatch = result[i];
			subs[--i] = submatch
				? elm$core$Maybe$Just(submatch)
				: elm$core$Maybe$Nothing;
		}
		out.push(A4(elm$regex$Regex$Match, result[0], result.index, number, _List_fromArray(subs)));
		prevLastIndex = re.lastIndex;
	}
	re.lastIndex = lastIndex;
	return _List_fromArray(out);
});


var _Regex_replaceAtMost = F4(function(n, re, replacer, string)
{
	var count = 0;
	function jsReplacer(match)
	{
		if (count++ >= n)
		{
			return match;
		}
		var i = arguments.length - 3;
		var submatches = new Array(i);
		while (i > 0)
		{
			var submatch = arguments[i];
			submatches[--i] = submatch
				? elm$core$Maybe$Just(submatch)
				: elm$core$Maybe$Nothing;
		}
		return replacer(A4(elm$regex$Regex$Match, match, arguments[arguments.length - 2], count, _List_fromArray(submatches)));
	}
	return string.replace(re, jsReplacer);
});

var _Regex_splitAtMost = F3(function(n, re, str)
{
	var string = str;
	var out = [];
	var start = re.lastIndex;
	var restoreLastIndex = re.lastIndex;
	while (n--)
	{
		var result = re.exec(string);
		if (!result) break;
		out.push(string.slice(start, result.index));
		start = re.lastIndex;
	}
	out.push(string.slice(start));
	re.lastIndex = restoreLastIndex;
	return _List_fromArray(out);
});

var _Regex_infinity = Infinity;



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});



function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800)
			+
			String.fromCharCode(code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

var _Json_decodeInt = { $: 2 };
var _Json_decodeBool = { $: 3 };
var _Json_decodeFloat = { $: 4 };
var _Json_decodeValue = { $: 5 };
var _Json_decodeString = { $: 6 };

function _Json_decodeList(decoder) { return { $: 7, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 8, b: decoder }; }

function _Json_decodeNull(value) { return { $: 9, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 10,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 11,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 12,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 13,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 14,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 15,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return elm$core$Result$Err(A2(elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 3:
			return (typeof value === 'boolean')
				? elm$core$Result$Ok(value)
				: _Json_expecting('a BOOL', value);

		case 2:
			if (typeof value !== 'number') {
				return _Json_expecting('an INT', value);
			}

			if (-2147483647 < value && value < 2147483647 && (value | 0) === value) {
				return elm$core$Result$Ok(value);
			}

			if (isFinite(value) && !(value % 1)) {
				return elm$core$Result$Ok(value);
			}

			return _Json_expecting('an INT', value);

		case 4:
			return (typeof value === 'number')
				? elm$core$Result$Ok(value)
				: _Json_expecting('a FLOAT', value);

		case 6:
			return (typeof value === 'string')
				? elm$core$Result$Ok(value)
				: (value instanceof String)
					? elm$core$Result$Ok(value + '')
					: _Json_expecting('a STRING', value);

		case 9:
			return (value === null)
				? elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 5:
			return elm$core$Result$Ok(_Json_wrap(value));

		case 7:
			if (!Array.isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 8:
			if (!Array.isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 10:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return (elm$core$Result$isOk(result)) ? result : elm$core$Result$Err(A2(elm$json$Json$Decode$Field, field, result.a));

		case 11:
			var index = decoder.e;
			if (!Array.isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return (elm$core$Result$isOk(result)) ? result : elm$core$Result$Err(A2(elm$json$Json$Decode$Index, index, result.a));

		case 12:
			if (typeof value !== 'object' || value === null || Array.isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!elm$core$Result$isOk(result))
					{
						return elm$core$Result$Err(A2(elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return elm$core$Result$Ok(elm$core$List$reverse(keyValuePairs));

		case 13:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return elm$core$Result$Ok(answer);

		case 14:
			var result = _Json_runHelp(decoder.b, value);
			return (!elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 15:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if (elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return elm$core$Result$Err(elm$json$Json$Decode$OneOf(elm$core$List$reverse(errors)));

		case 1:
			return elm$core$Result$Err(A2(elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!elm$core$Result$isOk(result))
		{
			return elm$core$Result$Err(A2(elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return elm$core$Result$Ok(toElmValue(array));
}

function _Json_toElmArray(array)
{
	return A2(elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return elm$core$Result$Err(A2(elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 3:
		case 2:
		case 4:
		case 6:
		case 5:
			return true;

		case 9:
			return x.c === y.c;

		case 7:
		case 8:
		case 12:
			return _Json_equality(x.b, y.b);

		case 10:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 11:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 13:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 14:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 15:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel);
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	elm$core$Result$isOk(result) || _Debug_crash(2, result.a);
	var managers = {};
	result = init(result.a);
	var model = result.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		result = A2(update, msg, model);
		stepper(model = result.a, viewMetadata);
		_Platform_dispatchEffects(managers, result.b, subscriptions(model));
	}

	_Platform_dispatchEffects(managers, result.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				p: bag.n,
				q: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.q)
		{
			x = temp.p(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		r: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].r;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		r: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].r;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}
var elm$core$Basics$False = {$: 'False'};
var elm$core$Basics$True = {$: 'True'};
var elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var elm$core$Maybe$Nothing = {$: 'Nothing'};
var elm$core$Basics$EQ = {$: 'EQ'};
var elm$core$Basics$LT = {$: 'LT'};
var elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var elm$core$Array$foldr = F3(
	function (func, baseCase, _n0) {
		var tree = _n0.c;
		var tail = _n0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3(elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3(elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			elm$core$Elm$JsArray$foldr,
			helper,
			A3(elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var elm$core$List$cons = _List_cons;
var elm$core$Array$toList = function (array) {
	return A3(elm$core$Array$foldr, elm$core$List$cons, _List_Nil, array);
};
var elm$core$Basics$GT = {$: 'GT'};
var elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3(elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var elm$core$Dict$toList = function (dict) {
	return A3(
		elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var elm$core$Dict$keys = function (dict) {
	return A3(
		elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2(elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var elm$core$Set$toList = function (_n0) {
	var dict = _n0.a;
	return elm$core$Dict$keys(dict);
};
var elm$core$String$startsWith = _String_startsWith;
var author$project$Graphql$Parser$ClassCaseName$isBuiltIn = function (_n0) {
	var rawName = _n0.a;
	return A2(elm$core$String$startsWith, '__', rawName) ? true : false;
};
var elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var elm$core$Basics$not = _Basics_not;
var elm$core$Basics$add = _Basics_add;
var elm$core$Basics$gt = _Utils_gt;
var elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var elm$core$List$reverse = function (list) {
	return A3(elm$core$List$foldl, elm$core$List$cons, _List_Nil, list);
};
var elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							elm$core$List$foldl,
							fn,
							acc,
							elm$core$List$reverse(r4)) : A4(elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4(elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var elm$core$List$filter = F2(
	function (isGood, list) {
		return A3(
			elm$core$List$foldr,
			F2(
				function (x, xs) {
					return isGood(x) ? A2(elm$core$List$cons, x, xs) : xs;
				}),
			_List_Nil,
			list);
	});
var author$project$Graphql$Generator$Group$excludeBuiltIns = function (typeDefinitions) {
	return A2(
		elm$core$List$filter,
		function (_n0) {
			var name = _n0.a;
			var definableType = _n0.b;
			var description = _n0.c;
			return !author$project$Graphql$Parser$ClassCaseName$isBuiltIn(name);
		},
		typeDefinitions);
};
var elm$core$Basics$neq = _Utils_notEqual;
var author$project$Graphql$Generator$Group$excludeMutation = F2(
	function (_n0, typeDefinitions) {
		var mutation = _n0.mutation;
		if (mutation.$ === 'Just') {
			var mutationObjectName = mutation.a;
			return A2(
				elm$core$List$filter,
				function (_n2) {
					var name = _n2.a;
					var definableType = _n2.b;
					var description = _n2.c;
					return !_Utils_eq(name, mutationObjectName);
				},
				typeDefinitions);
		} else {
			return typeDefinitions;
		}
	});
var author$project$Graphql$Generator$Group$excludeQuery = F2(
	function (_n0, typeDefinitions) {
		var query = _n0.query;
		return A2(
			elm$core$List$filter,
			function (_n1) {
				var name = _n1.a;
				var definableType = _n1.b;
				var description = _n1.c;
				return !_Utils_eq(name, query);
			},
			typeDefinitions);
	});
var author$project$Graphql$Generator$Group$excludeSubscription = F2(
	function (_n0, typeDefinitions) {
		var subscription = _n0.subscription;
		if (subscription.$ === 'Just') {
			var subscriptionObjectName = subscription.a;
			return A2(
				elm$core$List$filter,
				function (_n2) {
					var name = _n2.a;
					var definableType = _n2.b;
					var description = _n2.c;
					return !_Utils_eq(name, subscriptionObjectName);
				},
				typeDefinitions);
		} else {
			return typeDefinitions;
		}
	});
var author$project$Graphql$Parser$ClassCaseName$raw = function (_n0) {
	var rawName = _n0.a;
	return rawName;
};
var elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var elm$core$Dict$empty = elm$core$Dict$RBEmpty_elm_builtin;
var elm$core$Dict$Black = {$: 'Black'};
var elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var elm$core$Basics$compare = _Utils_compare;
var elm$core$Dict$Red = {$: 'Red'};
var elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _n1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _n3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					elm$core$Dict$RBNode_elm_builtin,
					elm$core$Dict$Red,
					key,
					value,
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
				var _n5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _n6 = left.d;
				var _n7 = _n6.a;
				var llK = _n6.b;
				var llV = _n6.c;
				var llLeft = _n6.d;
				var llRight = _n6.e;
				var lRight = left.e;
				return A5(
					elm$core$Dict$RBNode_elm_builtin,
					elm$core$Dict$Red,
					lK,
					lV,
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5(elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Red, key, value, elm$core$Dict$RBEmpty_elm_builtin, elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _n1 = A2(elm$core$Basics$compare, key, nKey);
			switch (_n1.$) {
				case 'LT':
					return A5(
						elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3(elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
					return A5(elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3(elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _n0 = A3(elm$core$Dict$insertHelp, key, value, dict);
		if ((_n0.$ === 'RBNode_elm_builtin') && (_n0.a.$ === 'Red')) {
			var _n1 = _n0.a;
			var k = _n0.b;
			var v = _n0.c;
			var l = _n0.d;
			var r = _n0.e;
			return A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _n0;
			return x;
		}
	});
var elm$core$Dict$fromList = function (assocs) {
	return A3(
		elm$core$List$foldl,
		F2(
			function (_n0, dict) {
				var key = _n0.a;
				var value = _n0.b;
				return A3(elm$core$Dict$insert, key, value, dict);
			}),
		elm$core$Dict$empty,
		assocs);
};
var elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _n0 = f(mx);
		if (_n0.$ === 'Just') {
			var x = _n0.a;
			return A2(elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			elm$core$List$foldr,
			elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var author$project$Graphql$Generator$Group$interfacePossibleTypesDict = function (typeDefs) {
	return elm$core$Dict$fromList(
		A2(
			elm$core$List$filterMap,
			function (_n0) {
				var typeName = _n0.a;
				var definableType = _n0.b;
				var description = _n0.c;
				if (definableType.$ === 'InterfaceType') {
					var fields = definableType.a;
					var possibleTypes = definableType.b;
					return elm$core$Maybe$Just(
						_Utils_Tuple2(
							author$project$Graphql$Parser$ClassCaseName$raw(typeName),
							possibleTypes));
				} else {
					return elm$core$Maybe$Nothing;
				}
			},
			typeDefs));
};
var elm$core$Basics$append = _Utils_append;
var elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var author$project$Graphql$Generator$Group$moduleToFileName = function (modulePath) {
	return A2(elm$core$String$join, '/', modulePath) + '.elm';
};
var elm$core$Maybe$map = F2(
	function (f, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return elm$core$Maybe$Just(
				f(value));
		} else {
			return elm$core$Maybe$Nothing;
		}
	});
var elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var elm$core$Array$branchFactor = 32;
var elm$core$Basics$ceiling = _Basics_ceiling;
var elm$core$Basics$fdiv = _Basics_fdiv;
var elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var elm$core$Basics$toFloat = _Basics_toFloat;
var elm$core$Array$shiftStep = elm$core$Basics$ceiling(
	A2(elm$core$Basics$logBase, 2, elm$core$Array$branchFactor));
var elm$core$Elm$JsArray$empty = _JsArray_empty;
var elm$core$Array$empty = A4(elm$core$Array$Array_elm_builtin, 0, elm$core$Array$shiftStep, elm$core$Elm$JsArray$empty, elm$core$Elm$JsArray$empty);
var elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _n0 = A2(elm$core$Elm$JsArray$initializeFromList, elm$core$Array$branchFactor, nodes);
			var node = _n0.a;
			var remainingNodes = _n0.b;
			var newAcc = A2(
				elm$core$List$cons,
				elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var elm$core$Basics$eq = _Utils_equal;
var elm$core$Tuple$first = function (_n0) {
	var x = _n0.a;
	return x;
};
var elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = elm$core$Basics$ceiling(nodeListSize / elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2(elm$core$Elm$JsArray$initializeFromList, elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2(elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var elm$core$Basics$floor = _Basics_floor;
var elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var elm$core$Basics$mul = _Basics_mul;
var elm$core$Basics$sub = _Basics_sub;
var elm$core$Elm$JsArray$length = _JsArray_length;
var elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				elm$core$Array$Array_elm_builtin,
				elm$core$Elm$JsArray$length(builder.tail),
				elm$core$Array$shiftStep,
				elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * elm$core$Array$branchFactor;
			var depth = elm$core$Basics$floor(
				A2(elm$core$Basics$logBase, elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2(elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				elm$core$Array$Array_elm_builtin,
				elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2(elm$core$Basics$max, 5, depth * elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var elm$core$Basics$lt = _Utils_lt;
var elm$core$Array$fromListHelp = F3(
	function (list, nodeList, nodeListSize) {
		fromListHelp:
		while (true) {
			var _n0 = A2(elm$core$Elm$JsArray$initializeFromList, elm$core$Array$branchFactor, list);
			var jsArray = _n0.a;
			var remainingItems = _n0.b;
			if (_Utils_cmp(
				elm$core$Elm$JsArray$length(jsArray),
				elm$core$Array$branchFactor) < 0) {
				return A2(
					elm$core$Array$builderToArray,
					true,
					{nodeList: nodeList, nodeListSize: nodeListSize, tail: jsArray});
			} else {
				var $temp$list = remainingItems,
					$temp$nodeList = A2(
					elm$core$List$cons,
					elm$core$Array$Leaf(jsArray),
					nodeList),
					$temp$nodeListSize = nodeListSize + 1;
				list = $temp$list;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue fromListHelp;
			}
		}
	});
var elm$core$Array$fromList = function (list) {
	if (!list.b) {
		return elm$core$Array$empty;
	} else {
		return A3(elm$core$Array$fromListHelp, list, _List_Nil, 0);
	}
};
var elm$regex$Regex$Match = F4(
	function (match, index, number, submatches) {
		return {index: index, match: match, number: number, submatches: submatches};
	});
var elm$regex$Regex$replace = _Regex_replaceAtMost(_Regex_infinity);
var elm$core$Bitwise$shiftRightZfBy = _Bitwise_shiftRightZfBy;
var elm$core$Array$bitMask = 4294967295 >>> (32 - elm$core$Array$shiftStep);
var elm$core$Bitwise$and = _Bitwise_and;
var elm$core$Elm$JsArray$unsafeGet = _JsArray_unsafeGet;
var elm$core$Array$getHelp = F3(
	function (shift, index, tree) {
		getHelp:
		while (true) {
			var pos = elm$core$Array$bitMask & (index >>> shift);
			var _n0 = A2(elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_n0.$ === 'SubTree') {
				var subTree = _n0.a;
				var $temp$shift = shift - elm$core$Array$shiftStep,
					$temp$index = index,
					$temp$tree = subTree;
				shift = $temp$shift;
				index = $temp$index;
				tree = $temp$tree;
				continue getHelp;
			} else {
				var values = _n0.a;
				return A2(elm$core$Elm$JsArray$unsafeGet, elm$core$Array$bitMask & index, values);
			}
		}
	});
var elm$core$Bitwise$shiftLeftBy = _Bitwise_shiftLeftBy;
var elm$core$Array$tailIndex = function (len) {
	return (len >>> 5) << 5;
};
var elm$core$Basics$ge = _Utils_ge;
var elm$core$Basics$or = _Basics_or;
var elm$core$Array$get = F2(
	function (index, _n0) {
		var len = _n0.a;
		var startShift = _n0.b;
		var tree = _n0.c;
		var tail = _n0.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? elm$core$Maybe$Nothing : ((_Utils_cmp(
			index,
			elm$core$Array$tailIndex(len)) > -1) ? elm$core$Maybe$Just(
			A2(elm$core$Elm$JsArray$unsafeGet, elm$core$Array$bitMask & index, tail)) : elm$core$Maybe$Just(
			A3(elm$core$Array$getHelp, startShift, index, tree)));
	});
var elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var elm$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		if (maybeValue.$ === 'Just') {
			var value = maybeValue.a;
			return callback(value);
		} else {
			return elm$core$Maybe$Nothing;
		}
	});
var elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var elm$core$String$length = _String_length;
var elm$core$String$slice = _String_slice;
var elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			elm$core$String$slice,
			n,
			elm$core$String$length(string),
			string);
	});
var elm$core$Basics$negate = function (n) {
	return -n;
};
var elm$core$String$dropRight = F2(
	function (n, string) {
		return (n < 1) ? string : A3(elm$core$String$slice, 0, -n, string);
	});
var elm$core$String$toInt = _String_toInt;
var lukewestby$elm_string_interpolate$String$Interpolate$applyInterpolation = F2(
	function (replacements, _n0) {
		var match = _n0.match;
		var ordinalString = A2(
			elm$core$Basics$composeL,
			elm$core$String$dropLeft(1),
			elm$core$String$dropRight(1))(match);
		return A2(
			elm$core$Maybe$withDefault,
			'',
			A2(
				elm$core$Maybe$andThen,
				function (value) {
					return A2(elm$core$Array$get, value, replacements);
				},
				elm$core$String$toInt(ordinalString)));
	});
var elm$regex$Regex$fromStringWith = _Regex_fromStringWith;
var elm$regex$Regex$fromString = function (string) {
	return A2(
		elm$regex$Regex$fromStringWith,
		{caseInsensitive: false, multiline: false},
		string);
};
var elm$regex$Regex$never = _Regex_never;
var lukewestby$elm_string_interpolate$String$Interpolate$interpolationRegex = A2(
	elm$core$Maybe$withDefault,
	elm$regex$Regex$never,
	elm$regex$Regex$fromString('\\{\\d+\\}'));
var lukewestby$elm_string_interpolate$String$Interpolate$interpolate = F2(
	function (string, args) {
		var asArray = elm$core$Array$fromList(args);
		return A3(
			elm$regex$Regex$replace,
			lukewestby$elm_string_interpolate$String$Interpolate$interpolationRegex,
			lukewestby$elm_string_interpolate$String$Interpolate$applyInterpolation(asArray),
			string);
	});
var author$project$Graphql$Generator$DocComment$argDoc = function (_n0) {
	var name = _n0.name;
	var description = _n0.description;
	return A2(
		elm$core$Maybe$map,
		function (aDescription) {
			return A2(
				lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
				'  - {0} - {1}',
				_List_fromArray(
					[name, aDescription]));
		},
		description);
};
var author$project$Graphql$Generator$DocComment$argsDoc = function (args) {
	var _n0 = A2(elm$core$List$filterMap, author$project$Graphql$Generator$DocComment$argDoc, args);
	if (!_n0.b) {
		return '';
	} else {
		var argDocs = _n0;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'\n\n{0}\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '\n', argDocs)
				]));
	}
};
var elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var author$project$Graphql$Generator$DocComment$hasDocs = F2(
	function (mainDescription, itemDescriptions) {
		if (mainDescription.$ === 'Just') {
			var string = mainDescription.a;
			return true;
		} else {
			return !elm$core$List$isEmpty(
				A2(
					elm$core$List$filterMap,
					function ($) {
						return $.description;
					},
					itemDescriptions));
		}
	});
var author$project$Graphql$Generator$DocComment$generate_ = F2(
	function (mainDescription, itemDescriptions) {
		return A2(author$project$Graphql$Generator$DocComment$hasDocs, mainDescription, itemDescriptions) ? A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{-|{0}{1}\n-}\n',
			_List_fromArray(
				[
					A2(
					elm$core$Maybe$withDefault,
					'',
					A2(
						elm$core$Maybe$map,
						function (description) {
							return ' ' + description;
						},
						mainDescription)),
					author$project$Graphql$Generator$DocComment$argsDoc(itemDescriptions)
				])) : '';
	});
var elm$core$Char$toUpper = _Char_toUpper;
var elm$core$String$fromList = _String_fromList;
var elm$core$String$foldr = _String_foldr;
var elm$core$String$toList = function (string) {
	return A3(elm$core$String$foldr, elm$core$List$cons, _List_Nil, string);
};
var author$project$Graphql$Generator$Normalize$capitilize = function (string) {
	var _n0 = elm$core$String$toList(string);
	if (_n0.b) {
		var firstChar = _n0.a;
		var rest = _n0.b;
		return elm$core$String$fromList(
			A2(
				elm$core$List$cons,
				elm$core$Char$toUpper(firstChar),
				rest));
	} else {
		return '';
	}
};
var elm$core$String$toUpper = _String_toUpper;
var author$project$Graphql$Generator$Normalize$isAllUpper = function (string) {
	return _Utils_eq(
		elm$core$String$toUpper(string),
		string);
};
var elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var elm$core$Debug$todo = _Debug_todo;
var elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return elm$core$Maybe$Just(x);
	} else {
		return elm$core$Maybe$Nothing;
	}
};
var elm$regex$Regex$find = _Regex_findAtMost(_Regex_infinity);
var author$project$Graphql$Generator$Normalize$underscores = function (string) {
	var regexFromString = A2(
		elm$core$Basics$composeR,
		elm$regex$Regex$fromString,
		elm$core$Maybe$withDefault(elm$regex$Regex$never));
	var _n0 = A2(
		elm$core$Maybe$map,
		function ($) {
			return $.submatches;
		},
		elm$core$List$head(
			A2(
				elm$regex$Regex$find,
				regexFromString('^(_*)([^_]?.*[^_]?)(_*)$'),
				string)));
	if (_n0.$ === 'Just') {
		if ((((_n0.a.b && _n0.a.b.b) && (_n0.a.b.a.$ === 'Just')) && _n0.a.b.b.b) && (!_n0.a.b.b.b.b)) {
			var _n1 = _n0.a;
			var leading = _n1.a;
			var _n2 = _n1.b;
			var remaining = _n2.a.a;
			var _n3 = _n2.b;
			var trailing = _n3.a;
			return {
				leading: A2(elm$core$Maybe$withDefault, '', leading),
				remaining: remaining,
				trailing: A2(elm$core$Maybe$withDefault, '', trailing)
			};
		} else {
			return _Debug_todo(
				'Graphql.Generator.Normalize',
				{
					start: {line: 34, column: 13},
					end: {line: 34, column: 23}
				})('Unexpected regex result for name ' + string);
		}
	} else {
		return _Debug_todo(
			'Graphql.Generator.Normalize',
			{
				start: {line: 31, column: 13},
				end: {line: 31, column: 23}
			})('Got nothing');
	}
};
var elm$core$String$toLower = _String_toLower;
var elm$core$Basics$always = F2(
	function (a, _n0) {
		return a;
	});
var elm$core$String$trim = _String_trim;
var elm_community$string_extra$String$Extra$regexFromString = A2(
	elm$core$Basics$composeR,
	elm$regex$Regex$fromString,
	elm$core$Maybe$withDefault(elm$regex$Regex$never));
var elm_community$string_extra$String$Extra$camelize = function (string) {
	return A3(
		elm$regex$Regex$replace,
		elm_community$string_extra$String$Extra$regexFromString('[-_\\s]+(.)?'),
		function (_n0) {
			var submatches = _n0.submatches;
			if (submatches.b && (submatches.a.$ === 'Just')) {
				var match = submatches.a.a;
				return elm$core$String$toUpper(match);
			} else {
				return '';
			}
		},
		elm$core$String$trim(string));
};
var elm_community$string_extra$String$Extra$regexEscape = A2(
	elm$regex$Regex$replace,
	elm_community$string_extra$String$Extra$regexFromString('[-/\\^$*+?.()|[\\]{}]'),
	function (_n0) {
		var match = _n0.match;
		return '\\' + match;
	});
var elm_community$string_extra$String$Extra$replace = F3(
	function (search, substitution, string) {
		return A3(
			elm$regex$Regex$replace,
			elm_community$string_extra$String$Extra$regexFromString(
				elm_community$string_extra$String$Extra$regexEscape(search)),
			function (_n0) {
				return substitution;
			},
			string);
	});
var elm$core$String$cons = _String_cons;
var elm$core$String$uncons = _String_uncons;
var elm_community$string_extra$String$Extra$changeCase = F2(
	function (mutator, word) {
		return A2(
			elm$core$Maybe$withDefault,
			'',
			A2(
				elm$core$Maybe$map,
				function (_n0) {
					var head = _n0.a;
					var tail = _n0.b;
					return A2(
						elm$core$String$cons,
						mutator(head),
						tail);
				},
				elm$core$String$uncons(word)));
	});
var elm_community$string_extra$String$Extra$toSentenceCase = function (word) {
	return A2(elm_community$string_extra$String$Extra$changeCase, elm$core$Char$toUpper, word);
};
var elm_community$string_extra$String$Extra$classify = function (string) {
	return elm_community$string_extra$String$Extra$toSentenceCase(
		A3(
			elm_community$string_extra$String$Extra$replace,
			' ',
			'',
			elm_community$string_extra$String$Extra$camelize(
				A3(
					elm$regex$Regex$replace,
					elm_community$string_extra$String$Extra$regexFromString('[\\W_]'),
					elm$core$Basics$always(' '),
					string))));
};
var author$project$Graphql$Generator$Normalize$capitalized = function (name) {
	var group = author$project$Graphql$Generator$Normalize$underscores(name);
	return _Utils_ap(
		author$project$Graphql$Generator$Normalize$isAllUpper(group.remaining) ? elm_community$string_extra$String$Extra$classify(
			elm$core$String$toLower(group.remaining)) : author$project$Graphql$Generator$Normalize$capitilize(group.remaining),
		_Utils_ap(group.leading, group.trailing));
};
var author$project$Graphql$Parser$ClassCaseName$normalized = function (_n0) {
	var rawName = _n0.a;
	return author$project$Graphql$Generator$Normalize$capitalized(rawName);
};
var elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var author$project$Graphql$Generator$DocComment$generateForEnum = F2(
	function (description, enumValues) {
		return A2(
			author$project$Graphql$Generator$DocComment$generate_,
			description,
			A2(
				elm$core$List$map,
				function (enumValue) {
					return {
						description: enumValue.description,
						name: author$project$Graphql$Parser$ClassCaseName$normalized(enumValue.name)
					};
				},
				enumValues));
	});
var author$project$Graphql$Generator$Enum$enumDocs = F2(
	function (enumDescription, enumValues) {
		return A2(author$project$Graphql$Generator$DocComment$generateForEnum, enumDescription, enumValues);
	});
var author$project$Graphql$Generator$Enum$enumDecoder = F2(
	function (enumName, enumValues) {
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'decoder : Decoder {0}\ndecoder =\n    Decode.string\n        |> Decode.andThen\n            (\\string ->\n                case string of\n',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(enumName)
				])) + (A2(
			elm$core$String$join,
			'\n\n',
			A2(
				elm$core$List$map,
				function (enumValue) {
					return '                    \"' + (author$project$Graphql$Parser$ClassCaseName$raw(enumValue) + ('\" ->\n                        Decode.succeed ' + author$project$Graphql$Parser$ClassCaseName$normalized(enumValue)));
				},
				A2(
					elm$core$List$map,
					function ($) {
						return $.name;
					},
					enumValues))) + ('\n\n                    _ ->\n                        Decode.fail ("Invalid ' + (author$project$Graphql$Parser$ClassCaseName$normalized(enumName) + ' type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")\n        )\n        ')));
	});
var author$project$Graphql$Generator$Enum$toStringCase = function (enumValue) {
	return A2(
		lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
		'        {0} ->\n                "{1}"\n',
		_List_fromArray(
			[
				author$project$Graphql$Parser$ClassCaseName$normalized(enumValue.name),
				author$project$Graphql$Parser$ClassCaseName$raw(enumValue.name)
			]));
};
var author$project$Graphql$Generator$Enum$enumToString = F2(
	function (enumName, enumValues) {
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.\n-}\ntoString : {0} -> String\ntoString enum =\n    case enum of\n{1}',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(enumName),
					A2(
					elm$core$String$join,
					'\n\n',
					A2(elm$core$List$map, author$project$Graphql$Generator$Enum$toStringCase, enumValues))
				]));
	});
var author$project$Graphql$Generator$Enum$enumType = F2(
	function (enumName, enumValues) {
		return 'type ' + (author$project$Graphql$Parser$ClassCaseName$normalized(enumName) + ('\n    = ' + (A2(
			elm$core$String$join,
			'\n    | ',
			A2(
				elm$core$List$map,
				author$project$Graphql$Parser$ClassCaseName$normalized,
				A2(
					elm$core$List$map,
					function ($) {
						return $.name;
					},
					enumValues))) + '\n')));
	});
var author$project$Graphql$Generator$Enum$prepend = F4(
	function (moduleName, enumName, enumValues, docComment) {
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\nimport Json.Decode as Decode exposing (Decoder)\n\n\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '.', moduleName)
				])) + (docComment + (A2(author$project$Graphql$Generator$Enum$enumType, enumName, enumValues) + (A2(author$project$Graphql$Generator$Enum$enumDecoder, enumName, enumValues) + ('\n\n' + A2(author$project$Graphql$Generator$Enum$enumToString, enumName, enumValues)))));
	});
var author$project$Graphql$Generator$Enum$generate = F4(
	function (enumName, moduleName, enumValues, description) {
		return A4(
			author$project$Graphql$Generator$Enum$prepend,
			moduleName,
			enumName,
			enumValues,
			A2(author$project$Graphql$Generator$Enum$enumDocs, description, enumValues));
	});
var author$project$Graphql$Generator$Normalize$elmReservedWords = _List_fromArray(
	['as', 'case', 'else', 'exposing', 'if', 'import', 'in', 'infix', 'let', 'module', 'of', 'port', 'then', 'type', 'where']);
var elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var author$project$Graphql$Generator$Normalize$normalizeIfElmReserved = function (name) {
	return A2(elm$core$List$member, name, author$project$Graphql$Generator$Normalize$elmReservedWords) ? (name + '_') : name;
};
var elm$core$Char$toLower = _Char_toLower;
var elm_community$string_extra$String$Extra$decapitalize = function (word) {
	return A2(elm_community$string_extra$String$Extra$changeCase, elm$core$Char$toLower, word);
};
var author$project$Graphql$Generator$Normalize$decapitalized = function (name) {
	return author$project$Graphql$Generator$Normalize$normalizeIfElmReserved(
		elm_community$string_extra$String$Extra$decapitalize(
			author$project$Graphql$Generator$Normalize$capitalized(name)));
};
var author$project$Graphql$Parser$CamelCaseName$normalized = function (_n0) {
	var name = _n0.a;
	return author$project$Graphql$Generator$Normalize$decapitalized(name);
};
var author$project$Graphql$Generator$DocComment$generate = function (_n0) {
	var description = _n0.description;
	var args = _n0.args;
	return A2(
		author$project$Graphql$Generator$DocComment$generate_,
		description,
		A2(
			elm$core$List$map,
			function (arg) {
				return {
					description: arg.description,
					name: author$project$Graphql$Parser$CamelCaseName$normalized(arg.name)
				};
			},
			args));
};
var author$project$Graphql$Generator$Field$argsListString = function (_n0) {
	var annotatedArgs = _n0.annotatedArgs;
	return _Utils_eq(annotatedArgs, _List_Nil) ? '' : (A2(
		elm$core$String$join,
		' ',
		A2(
			elm$core$List$map,
			function ($) {
				return $.arg;
			},
			annotatedArgs)) + ' ');
};
var author$project$Graphql$Generator$Field$fieldArgsString = function (_n0) {
	var fieldArgs = _n0.fieldArgs;
	if (!fieldArgs.b) {
		return '[]';
	} else {
		if (!fieldArgs.b.b) {
			var single = fieldArgs.a;
			return single;
		} else {
			return '(' + (A2(elm$core$String$join, ' ++ ', fieldArgs) + ')');
		}
	}
};
var author$project$Graphql$Parser$CamelCaseName$raw = function (_n0) {
	var name = _n0.a;
	return name;
};
var author$project$Graphql$Generator$Field$typeAliasesToString = F2(
	function (field, fieldGenerator) {
		return _Utils_eq(fieldGenerator.typeAliases, _List_Nil) ? elm$core$Maybe$Nothing : elm$core$Maybe$Just(
			A2(
				elm$core$String$join,
				'\n\n',
				A2(
					elm$core$List$map,
					function (_n0) {
						var suffix = _n0.suffix;
						var body = _n0.body;
						return A2(
							lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
							'type alias {0}{1} = {2}',
							_List_fromArray(
								[
									elm_community$string_extra$String$Extra$classify(
									author$project$Graphql$Parser$CamelCaseName$raw(field.name)),
									suffix,
									body
								]));
					},
					fieldGenerator.typeAliases)));
	});
var author$project$Graphql$Generator$Let$generate = function (letBindings) {
	var toLetString = function (_n0) {
		var name = _n0.a;
		var value = _n0.b;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'        {0} =\n            {1}',
			_List_fromArray(
				[name, value]));
	};
	var letString = A2(
		elm$core$String$join,
		'\n\n',
		A2(elm$core$List$map, toLetString, letBindings));
	return _Utils_eq(letBindings, _List_Nil) ? '' : A2(
		lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
		'\n    let\n{0}\n    in',
		_List_fromArray(
			[letString]));
};
var elm$core$Basics$identity = function (x) {
	return x;
};
var author$project$Graphql$Generator$Field$fieldGeneratorToString = F3(
	function (returnAnnotation, field, fieldGenerator) {
		var fieldTypeAnnotation = A2(
			elm$core$String$join,
			' -> ',
			_Utils_ap(
				A2(
					elm$core$List$map,
					function ($) {
						return $.annotation;
					},
					fieldGenerator.annotatedArgs),
				_List_fromArray(
					[returnAnnotation])));
		return A2(
			elm$core$String$join,
			'\n\n',
			A2(
				elm$core$List$filterMap,
				elm$core$Basics$identity,
				_List_fromArray(
					[
						A2(author$project$Graphql$Generator$Field$typeAliasesToString, field, fieldGenerator),
						elm$core$Maybe$Just(
						A2(
							lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
							'{9}{6} : {3}\n{6} {4}={7}\n      {5} "{0}" {1} ({2}){8}\n',
							_List_fromArray(
								[
									author$project$Graphql$Parser$CamelCaseName$raw(field.name),
									author$project$Graphql$Generator$Field$fieldArgsString(fieldGenerator),
									fieldGenerator.decoder,
									fieldTypeAnnotation,
									author$project$Graphql$Generator$Field$argsListString(fieldGenerator),
									'Object' + fieldGenerator.otherThing,
									author$project$Graphql$Parser$CamelCaseName$normalized(field.name),
									author$project$Graphql$Generator$Let$generate(fieldGenerator.letBindings),
									A2(elm$core$Maybe$withDefault, '', fieldGenerator.objectDecoderChain),
									author$project$Graphql$Generator$DocComment$generate(field)
								])))
					])));
	});
var author$project$Graphql$Generator$Field$forObject_ = F4(
	function (context, thisObjectName, field, fieldGenerator) {
		return A3(
			author$project$Graphql$Generator$Field$fieldGeneratorToString,
			A2(
				lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
				'Field {0} {1}',
				_List_fromArray(
					[
						fieldGenerator.decoderAnnotation,
						A2(elm$core$String$join, '.', thisObjectName)
					])),
			field,
			fieldGenerator);
	});
var author$project$Graphql$Generator$Field$prependArg = F2(
	function (annotatedArg, fieldGenerator) {
		var annotation = annotatedArg.annotation;
		var arg = annotatedArg.arg;
		return _Utils_update(
			fieldGenerator,
			{
				annotatedArgs: A2(elm$core$List$cons, annotatedArg, fieldGenerator.annotatedArgs)
			});
	});
var author$project$Graphql$Generator$OptionalArgs$annotation = function (fieldName) {
	return A2(
		lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
		'({0}OptionalArguments -> {0}OptionalArguments)',
		_List_fromArray(
			[fieldName]));
};
var author$project$Graphql$Generator$ModuleName$enum = F2(
	function (_n0, name) {
		var apiSubmodule = _n0.apiSubmodule;
		return _Utils_ap(
			apiSubmodule,
			_List_fromArray(
				[
					'Enum',
					author$project$Graphql$Parser$ClassCaseName$normalized(name)
				]));
	});
var author$project$Graphql$Generator$ModuleName$inputObject = F2(
	function (_n0, name) {
		var apiSubmodule = _n0.apiSubmodule;
		return _Utils_ap(
			apiSubmodule,
			_List_fromArray(
				['InputObject']));
	});
var author$project$Graphql$Generator$Decoder$generateEncoder_ = F3(
	function (forInputObject, apiSubmodule, _n0) {
		var referrableType = _n0.a;
		var isNullable = _n0.b;
		var isNullableString = function () {
			if (isNullable.$ === 'Nullable') {
				return ' |> Encode.maybe';
			} else {
				return '';
			}
		}();
		switch (referrableType.$) {
			case 'Scalar':
				var scalar = referrableType.a;
				switch (scalar.$) {
					case 'String':
						return 'Encode.string' + isNullableString;
					case 'Boolean':
						return 'Encode.bool' + isNullableString;
					case 'Int':
						return 'Encode.int' + isNullableString;
					case 'Float':
						return 'Encode.float' + isNullableString;
					default:
						var customScalarName = scalar.a;
						var constructor = A2(
							elm$core$String$join,
							'.',
							_Utils_ap(
								apiSubmodule,
								_Utils_ap(
									_List_fromArray(
										['Scalar']),
									_List_fromArray(
										[
											author$project$Graphql$Parser$ClassCaseName$normalized(customScalarName)
										]))));
						return _Utils_ap(
							A2(
								lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
								'(\\({0} raw) -> Encode.string raw)',
								_List_fromArray(
									[constructor])),
							isNullableString);
				}
			case 'List':
				var typeRef = referrableType.a;
				return A3(author$project$Graphql$Generator$Decoder$generateEncoder_, forInputObject, apiSubmodule, typeRef) + (isNullableString + ' |> Encode.list');
			case 'ObjectRef':
				var objectName = referrableType.a;
				return _Debug_todo(
					'Graphql.Generator.Decoder',
					{
						start: {line: 120, column: 13},
						end: {line: 120, column: 23}
					})('I don\'t expect to see object references as argument types.');
			case 'InterfaceRef':
				var interfaceName = referrableType.a;
				return _Debug_todo(
					'Graphql.Generator.Decoder',
					{
						start: {line: 123, column: 13},
						end: {line: 123, column: 23}
					})('Interfaces are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Interfaces');
			case 'UnionRef':
				return _Debug_todo(
					'Graphql.Generator.Decoder',
					{
						start: {line: 126, column: 13},
						end: {line: 126, column: 23}
					})('Unions are never valid inputs http://facebook.github.io/graphql/October2016/#sec-Unions');
			case 'EnumRef':
				var enumName = referrableType.a;
				return A2(
					lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
					'(Encode.enum {0})' + isNullableString,
					_List_fromArray(
						[
							A2(
							elm$core$String$join,
							'.',
							_Utils_ap(
								A2(
									author$project$Graphql$Generator$ModuleName$enum,
									{apiSubmodule: apiSubmodule},
									enumName),
								_List_fromArray(
									['toString'])))
						]));
			default:
				var inputObjectName = referrableType.a;
				return _Utils_ap(
					A2(
						elm$core$String$join,
						'.',
						forInputObject ? _List_fromArray(
							[
								'encode' + author$project$Graphql$Parser$ClassCaseName$normalized(inputObjectName)
							]) : _Utils_ap(
							A2(
								author$project$Graphql$Generator$ModuleName$inputObject,
								{apiSubmodule: apiSubmodule},
								inputObjectName),
							_List_fromArray(
								[
									'encode' + author$project$Graphql$Parser$ClassCaseName$normalized(inputObjectName)
								]))),
					isNullableString);
		}
	});
var author$project$Graphql$Generator$Decoder$generateEncoder = author$project$Graphql$Generator$Decoder$generateEncoder_(false);
var author$project$Graphql$Parser$Type$NonNullable = {$: 'NonNullable'};
var author$project$Graphql$Parser$Type$TypeReference = F2(
	function (a, b) {
		return {$: 'TypeReference', a: a, b: b};
	});
var author$project$Graphql$Generator$OptionalArgs$argValue = F2(
	function (apiSubmodule, _n0) {
		var name = _n0.name;
		var typeOf = _n0.typeOf;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'Argument.optional "{0}" filledInOptionals.{1} ({2})',
			_List_fromArray(
				[
					author$project$Graphql$Parser$CamelCaseName$raw(name),
					author$project$Graphql$Parser$CamelCaseName$normalized(name),
					A2(
					author$project$Graphql$Generator$Decoder$generateEncoder,
					apiSubmodule,
					A2(author$project$Graphql$Parser$Type$TypeReference, typeOf, author$project$Graphql$Parser$Type$NonNullable))
				]));
	});
var author$project$Graphql$Generator$OptionalArgs$argValues = F2(
	function (apiSubmodule, optionalArgs) {
		var values = A2(
			elm$core$String$join,
			', ',
			A2(
				elm$core$List$map,
				author$project$Graphql$Generator$OptionalArgs$argValue(apiSubmodule),
				optionalArgs));
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'[ {0} ]',
			_List_fromArray(
				[values]));
	});
var author$project$Graphql$Generator$OptionalArgs$emptyRecord = function (optionalArgs) {
	var recordEntries = A2(
		elm$core$String$join,
		', ',
		A2(
			elm$core$List$map,
			function (_n0) {
				var name = _n0.name;
				return author$project$Graphql$Parser$CamelCaseName$normalized(name) + ' = Absent';
			},
			optionalArgs));
	return A2(
		lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
		'{ {0} }',
		_List_fromArray(
			[recordEntries]));
};
var author$project$Graphql$Generator$OptionalArgs$optionalArgOrNothing = function (_n0) {
	var name = _n0.name;
	var typeRef = _n0.typeRef;
	if (typeRef.b.$ === 'NonNullable') {
		var referrableType = typeRef.a;
		var _n2 = typeRef.b;
		return elm$core$Maybe$Nothing;
	} else {
		var referrableType = typeRef.a;
		var _n3 = typeRef.b;
		return elm$core$Maybe$Just(
			{name: name, typeOf: referrableType});
	}
};
var author$project$Graphql$Generator$ModuleName$enumTypeName = F2(
	function (_n0, name) {
		var apiSubmodule = _n0.apiSubmodule;
		return _Utils_ap(
			apiSubmodule,
			_List_fromArray(
				[
					'Enum',
					author$project$Graphql$Parser$ClassCaseName$normalized(name),
					author$project$Graphql$Parser$ClassCaseName$normalized(name)
				]));
	});
var author$project$Graphql$Generator$Decoder$generateTypeCommon = F4(
	function (fromInputObject, nullableString, apiSubmodule, _n0) {
		var referrableType = _n0.a;
		var isNullable = _n0.b;
		return function (typeString) {
			if (isNullable.$ === 'Nullable') {
				return A2(
					lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
					'({0} {1})',
					_List_fromArray(
						[nullableString, typeString]));
			} else {
				return typeString;
			}
		}(
			function () {
				switch (referrableType.$) {
					case 'Scalar':
						var scalar = referrableType.a;
						switch (scalar.$) {
							case 'String':
								return 'String';
							case 'Boolean':
								return 'Bool';
							case 'Int':
								return 'Int';
							case 'Float':
								return 'Float';
							default:
								var customScalarName = scalar.a;
								var constructor = A2(
									elm$core$String$join,
									'.',
									_Utils_ap(
										apiSubmodule,
										_Utils_ap(
											_List_fromArray(
												['Scalar']),
											_List_fromArray(
												[
													author$project$Graphql$Parser$ClassCaseName$normalized(customScalarName)
												]))));
								return constructor;
						}
					case 'List':
						var typeRef = referrableType.a;
						return '(List ' + (A3(author$project$Graphql$Generator$Decoder$generateType_, fromInputObject, apiSubmodule, typeRef) + ')');
					case 'ObjectRef':
						var objectName = referrableType.a;
						return 'decodesTo';
					case 'InterfaceRef':
						var interfaceName = referrableType.a;
						return 'decodesTo';
					case 'UnionRef':
						var unionName = referrableType.a;
						return 'decodesTo';
					case 'EnumRef':
						var enumName = referrableType.a;
						return A2(
							elm$core$String$join,
							'.',
							A2(
								author$project$Graphql$Generator$ModuleName$enumTypeName,
								{apiSubmodule: apiSubmodule},
								enumName));
					default:
						var inputObjectName = referrableType.a;
						return A2(
							elm$core$String$join,
							'.',
							fromInputObject ? _List_fromArray(
								[
									author$project$Graphql$Parser$ClassCaseName$normalized(inputObjectName)
								]) : _Utils_ap(
								A2(
									author$project$Graphql$Generator$ModuleName$inputObject,
									{apiSubmodule: apiSubmodule},
									inputObjectName),
								_List_fromArray(
									[
										author$project$Graphql$Parser$ClassCaseName$normalized(inputObjectName)
									])));
				}
			}());
	});
var author$project$Graphql$Generator$Decoder$generateType_ = F3(
	function (fromInputObject, apiSubmodule, typeRef) {
		return A4(author$project$Graphql$Generator$Decoder$generateTypeCommon, fromInputObject, 'Maybe', apiSubmodule, typeRef);
	});
var author$project$Graphql$Generator$Decoder$generateType = F2(
	function (apiSubmodule, typeRef) {
		return A4(author$project$Graphql$Generator$Decoder$generateTypeCommon, false, 'Maybe', apiSubmodule, typeRef);
	});
var elm$core$List$singleton = function (value) {
	return _List_fromArray(
		[value]);
};
var author$project$Graphql$Generator$OptionalArgs$typeAlias = F2(
	function (apiSubmodule, optionalArgs) {
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{ {0} }',
			elm$core$List$singleton(
				A2(
					elm$core$String$join,
					', ',
					A2(
						elm$core$List$map,
						function (_n0) {
							var name = _n0.name;
							var typeOf = _n0.typeOf;
							return author$project$Graphql$Parser$CamelCaseName$normalized(name) + (' : OptionalArgument ' + A2(
								author$project$Graphql$Generator$Decoder$generateType,
								apiSubmodule,
								A2(author$project$Graphql$Parser$Type$TypeReference, typeOf, author$project$Graphql$Parser$Type$NonNullable)));
						},
						optionalArgs))));
	});
var author$project$Graphql$Generator$OptionalArgs$generate = F2(
	function (apiSubmodule, allArgs) {
		var _n0 = A2(elm$core$List$filterMap, author$project$Graphql$Generator$OptionalArgs$optionalArgOrNothing, allArgs);
		if (!_n0.b) {
			return elm$core$Maybe$Nothing;
		} else {
			var optionalArgs = _n0;
			return elm$core$Maybe$Just(
				{
					annotatedArg: function (fieldName) {
						return {
							annotation: author$project$Graphql$Generator$OptionalArgs$annotation(fieldName),
							arg: 'fillInOptionals'
						};
					},
					letBindings: _List_fromArray(
						[
							_Utils_Tuple2(
							'filledInOptionals',
							'fillInOptionals ' + author$project$Graphql$Generator$OptionalArgs$emptyRecord(optionalArgs)),
							_Utils_Tuple2(
							'optionalArgs',
							A2(author$project$Graphql$Generator$OptionalArgs$argValues, apiSubmodule, optionalArgs) + '\n                |> List.filterMap identity')
						]),
					typeAlias: {
						body: A2(author$project$Graphql$Generator$OptionalArgs$typeAlias, apiSubmodule, optionalArgs),
						suffix: 'OptionalArguments'
					}
				});
		}
	});
var author$project$Graphql$Generator$Field$addOptionalArgs = F4(
	function (field, apiSubmodule, args, fieldGenerator) {
		var _n0 = A2(author$project$Graphql$Generator$OptionalArgs$generate, apiSubmodule, args);
		if (_n0.$ === 'Just') {
			var annotatedArg = _n0.a.annotatedArg;
			var letBindings = _n0.a.letBindings;
			var typeAlias = _n0.a.typeAlias;
			return A2(
				author$project$Graphql$Generator$Field$prependArg,
				annotatedArg(
					elm_community$string_extra$String$Extra$classify(
						author$project$Graphql$Parser$CamelCaseName$raw(field.name))),
				_Utils_update(
					fieldGenerator,
					{
						fieldArgs: A2(elm$core$List$cons, 'optionalArgs', fieldGenerator.fieldArgs),
						letBindings: _Utils_ap(fieldGenerator.letBindings, letBindings),
						typeAliases: A2(elm$core$List$cons, typeAlias, fieldGenerator.typeAliases)
					}));
		} else {
			return fieldGenerator;
		}
	});
var author$project$Graphql$Generator$RequiredArgs$requiredArgOrNothing = function (_n0) {
	var name = _n0.name;
	var typeRef = _n0.typeRef;
	if (typeRef.b.$ === 'NonNullable') {
		var referrableType = typeRef.a;
		var _n2 = typeRef.b;
		return elm$core$Maybe$Just(
			{name: name, referrableType: referrableType, typeRef: typeRef});
	} else {
		var referrableType = typeRef.a;
		var _n3 = typeRef.b;
		return elm$core$Maybe$Nothing;
	}
};
var author$project$Graphql$Generator$RequiredArgs$requiredArgAnnotation = F2(
	function (apiSubmodule, _n0) {
		var name = _n0.name;
		var typeRef = _n0.typeRef;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{0} : {1}',
			_List_fromArray(
				[
					author$project$Graphql$Parser$CamelCaseName$normalized(name),
					A2(author$project$Graphql$Generator$Decoder$generateType, apiSubmodule, typeRef)
				]));
	});
var author$project$Graphql$Generator$RequiredArgs$requiredArgsAnnotation = F2(
	function (apiSubmodule, requiredArgs) {
		var annotations = A2(
			elm$core$List$map,
			author$project$Graphql$Generator$RequiredArgs$requiredArgAnnotation(apiSubmodule),
			requiredArgs);
		return '{ ' + (A2(elm$core$String$join, ', ', annotations) + ' }');
	});
var author$project$Graphql$Generator$RequiredArgs$requiredArgString = F2(
	function (apiSubmodule, _n0) {
		var name = _n0.name;
		var referrableType = _n0.referrableType;
		var typeRef = _n0.typeRef;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'Argument.required \"{0}\" requiredArgs.{1} ({2})',
			_List_fromArray(
				[
					author$project$Graphql$Parser$CamelCaseName$raw(name),
					author$project$Graphql$Parser$CamelCaseName$normalized(name),
					A2(author$project$Graphql$Generator$Decoder$generateEncoder, apiSubmodule, typeRef)
				]));
	});
var author$project$Graphql$Generator$RequiredArgs$requiredArgsString = F2(
	function (apiSubmodule, requiredArgs) {
		var requiredArgContents = A2(
			elm$core$List$map,
			author$project$Graphql$Generator$RequiredArgs$requiredArgString(apiSubmodule),
			requiredArgs);
		return '[ ' + (A2(elm$core$String$join, ', ', requiredArgContents) + ' ]');
	});
var author$project$Graphql$Generator$RequiredArgs$generate = F2(
	function (apiSubmodule, args) {
		var requiredArgs = A2(elm$core$List$filterMap, author$project$Graphql$Generator$RequiredArgs$requiredArgOrNothing, args);
		return _Utils_eq(requiredArgs, _List_Nil) ? elm$core$Maybe$Nothing : elm$core$Maybe$Just(
			{
				annotation: function (fieldName) {
					return A2(
						lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
						'{0}RequiredArguments',
						_List_fromArray(
							[fieldName]));
				},
				list: A2(author$project$Graphql$Generator$RequiredArgs$requiredArgsString, apiSubmodule, requiredArgs),
				typeAlias: {
					body: A2(author$project$Graphql$Generator$RequiredArgs$requiredArgsAnnotation, apiSubmodule, requiredArgs),
					suffix: 'RequiredArguments'
				}
			});
	});
var author$project$Graphql$Generator$Field$addRequiredArgs = F4(
	function (field, apiSubmodule, args, fieldGenerator) {
		var _n0 = A2(author$project$Graphql$Generator$RequiredArgs$generate, apiSubmodule, args);
		if (_n0.$ === 'Just') {
			var annotation = _n0.a.annotation;
			var list = _n0.a.list;
			var typeAlias = _n0.a.typeAlias;
			return A2(
				author$project$Graphql$Generator$Field$prependArg,
				{
					annotation: annotation(
						elm_community$string_extra$String$Extra$classify(
							author$project$Graphql$Parser$CamelCaseName$raw(field.name))),
					arg: 'requiredArgs'
				},
				_Utils_update(
					fieldGenerator,
					{
						fieldArgs: _List_fromArray(
							[list]),
						typeAliases: A2(elm$core$List$cons, typeAlias, fieldGenerator.typeAliases)
					}));
		} else {
			return fieldGenerator;
		}
	});
var author$project$Graphql$Generator$Field$Interface = {$: 'Interface'};
var author$project$Graphql$Generator$Field$Object = {$: 'Object'};
var author$project$Graphql$Generator$Decoder$generateDecoder = F2(
	function (apiSubmodule, _n0) {
		var referrableType = _n0.a;
		var isNullable = _n0.b;
		return _Utils_ap(
			function () {
				switch (referrableType.$) {
					case 'Scalar':
						var scalar = referrableType.a;
						switch (scalar.$) {
							case 'String':
								return _List_fromArray(
									['Decode.string']);
							case 'Boolean':
								return _List_fromArray(
									['Decode.bool']);
							case 'Int':
								return _List_fromArray(
									['Decode.int']);
							case 'Float':
								return _List_fromArray(
									['Decode.float']);
							default:
								var customScalarName = scalar.a;
								var constructor = A2(
									elm$core$String$join,
									'.',
									_Utils_ap(
										apiSubmodule,
										_Utils_ap(
											_List_fromArray(
												['Scalar']),
											_List_fromArray(
												[
													author$project$Graphql$Parser$ClassCaseName$normalized(customScalarName)
												]))));
								return _List_fromArray(
									[
										'Object.scalarDecoder',
										A2(
										lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
										'Decode.map {0}',
										_List_fromArray(
											[constructor]))
									]);
						}
					case 'List':
						var listTypeRef = referrableType.a;
						return _Utils_ap(
							A2(author$project$Graphql$Generator$Decoder$generateDecoder, apiSubmodule, listTypeRef),
							_List_fromArray(
								['Decode.list']));
					case 'ObjectRef':
						var objectName = referrableType.a;
						return _List_fromArray(
							['identity']);
					case 'InterfaceRef':
						var interfaceName = referrableType.a;
						return _List_fromArray(
							['identity']);
					case 'UnionRef':
						var unionName = referrableType.a;
						return _List_fromArray(
							['identity']);
					case 'EnumRef':
						var enumName = referrableType.a;
						return _List_fromArray(
							[
								A2(
								elm$core$String$join,
								'.',
								_Utils_ap(
									A2(
										author$project$Graphql$Generator$ModuleName$enum,
										{apiSubmodule: apiSubmodule},
										enumName),
									_List_fromArray(
										['decoder'])))
							]);
					default:
						return _Debug_todo(
							'Graphql.Generator.Decoder',
							{
								start: {line: 59, column: 13},
								end: {line: 59, column: 23}
							})('Input objects are only for input not responses, shouldn\'t need decoder.');
				}
			}(),
			function () {
				if (isNullable.$ === 'Nullable') {
					return _List_fromArray(
						['Decode.nullable']);
				} else {
					return _List_Nil;
				}
			}());
	});
var author$project$Graphql$Generator$Field$initScalarField = F2(
	function (apiSubmodule, typeRef) {
		return {
			annotatedArgs: _List_Nil,
			decoder: A2(
				elm$core$String$join,
				' |> ',
				A2(author$project$Graphql$Generator$Decoder$generateDecoder, apiSubmodule, typeRef)),
			decoderAnnotation: A2(author$project$Graphql$Generator$Decoder$generateType, apiSubmodule, typeRef),
			fieldArgs: _List_Nil,
			letBindings: _List_Nil,
			objectDecoderChain: elm$core$Maybe$Nothing,
			otherThing: '.fieldDecoder',
			typeAliases: _List_Nil
		};
	});
var author$project$Graphql$Generator$Field$EnumLeaf = {$: 'EnumLeaf'};
var author$project$Graphql$Generator$Field$InterfaceLeaf = function (a) {
	return {$: 'InterfaceLeaf', a: a};
};
var author$project$Graphql$Generator$Field$ObjectLeaf = function (a) {
	return {$: 'ObjectLeaf', a: a};
};
var author$project$Graphql$Generator$Field$ScalarLeaf = {$: 'ScalarLeaf'};
var author$project$Graphql$Generator$Field$UnionLeaf = function (a) {
	return {$: 'UnionLeaf', a: a};
};
var author$project$Graphql$Generator$Field$leafType = function (_n0) {
	leafType:
	while (true) {
		var referrableType = _n0.a;
		var isNullable = _n0.b;
		switch (referrableType.$) {
			case 'ObjectRef':
				var refName = referrableType.a;
				return author$project$Graphql$Generator$Field$ObjectLeaf(refName);
			case 'InterfaceRef':
				var refName = referrableType.a;
				return author$project$Graphql$Generator$Field$InterfaceLeaf(refName);
			case 'UnionRef':
				var refName = referrableType.a;
				return author$project$Graphql$Generator$Field$UnionLeaf(refName);
			case 'Scalar':
				return author$project$Graphql$Generator$Field$ScalarLeaf;
			case 'List':
				var nestedReferrableType = referrableType.a;
				var $temp$_n0 = nestedReferrableType;
				_n0 = $temp$_n0;
				continue leafType;
			case 'EnumRef':
				return author$project$Graphql$Generator$Field$EnumLeaf;
			default:
				return _Debug_todo(
					'Graphql.Generator.Field',
					{
						start: {line: 264, column: 13},
						end: {line: 264, column: 23}
					})('Unexpected type');
		}
	}
};
var author$project$Graphql$Generator$ModuleName$interface = F2(
	function (_n0, name) {
		var apiSubmodule = _n0.apiSubmodule;
		return _Utils_ap(
			apiSubmodule,
			_List_fromArray(
				[
					'Interface',
					author$project$Graphql$Parser$ClassCaseName$normalized(name)
				]));
	});
var author$project$Graphql$Generator$ModuleName$object = F2(
	function (context, name) {
		return _Utils_eq(name, context.query) ? _List_fromArray(
			['RootQuery']) : (_Utils_eq(
			elm$core$Maybe$Just(name),
			context.mutation) ? _List_fromArray(
			['RootMutation']) : (_Utils_eq(
			elm$core$Maybe$Just(name),
			context.subscription) ? _List_fromArray(
			['RootSubscription']) : _Utils_ap(
			context.apiSubmodule,
			_List_fromArray(
				[
					'Object',
					author$project$Graphql$Parser$ClassCaseName$normalized(name)
				]))));
	});
var author$project$Graphql$Generator$ModuleName$union = F2(
	function (_n0, name) {
		var apiSubmodule = _n0.apiSubmodule;
		return _Utils_ap(
			apiSubmodule,
			_List_fromArray(
				[
					'Union',
					author$project$Graphql$Parser$ClassCaseName$normalized(name)
				]));
	});
var author$project$Graphql$Generator$ReferenceLeaf$Enum = {$: 'Enum'};
var author$project$Graphql$Generator$ReferenceLeaf$Interface = {$: 'Interface'};
var author$project$Graphql$Generator$ReferenceLeaf$Object = {$: 'Object'};
var author$project$Graphql$Generator$ReferenceLeaf$Scalar = {$: 'Scalar'};
var author$project$Graphql$Generator$ReferenceLeaf$Union = {$: 'Union'};
var author$project$Graphql$Generator$ReferenceLeaf$get = function (_n0) {
	get:
	while (true) {
		var referrableType = _n0.a;
		var isNullable = _n0.b;
		switch (referrableType.$) {
			case 'ObjectRef':
				return author$project$Graphql$Generator$ReferenceLeaf$Object;
			case 'Scalar':
				return author$project$Graphql$Generator$ReferenceLeaf$Scalar;
			case 'List':
				var nestedType = referrableType.a;
				var $temp$_n0 = nestedType;
				_n0 = $temp$_n0;
				continue get;
			case 'EnumRef':
				return author$project$Graphql$Generator$ReferenceLeaf$Enum;
			case 'InputObjectRef':
				return _Debug_todo(
					'Graphql.Generator.ReferenceLeaf',
					{
						start: {line: 35, column: 13},
						end: {line: 35, column: 23}
					})('TODO');
			case 'UnionRef':
				return author$project$Graphql$Generator$ReferenceLeaf$Union;
			default:
				return author$project$Graphql$Generator$ReferenceLeaf$Interface;
		}
	}
};
var author$project$Graphql$Parser$ClassCaseName$ClassCaseName = function (a) {
	return {$: 'ClassCaseName', a: a};
};
var author$project$Graphql$Parser$ClassCaseName$build = author$project$Graphql$Parser$ClassCaseName$ClassCaseName;
var author$project$Graphql$Generator$Field$objectThing = F4(
	function (context, typeRef, refName, objectOrInterface) {
		var apiSubmodule = context.apiSubmodule;
		var typeLock = function () {
			var _n0 = author$project$Graphql$Generator$ReferenceLeaf$get(typeRef);
			switch (_n0.$) {
				case 'Object':
					return A2(
						elm$core$String$join,
						'.',
						A2(
							author$project$Graphql$Generator$ModuleName$object,
							context,
							author$project$Graphql$Parser$ClassCaseName$build(refName)));
				case 'Interface':
					return A2(
						elm$core$String$join,
						'.',
						A2(
							author$project$Graphql$Generator$ModuleName$interface,
							context,
							author$project$Graphql$Parser$ClassCaseName$build(refName)));
				case 'Enum':
					return _Debug_todo(
						'Graphql.Generator.Field',
						{
							start: {line: 195, column: 21},
							end: {line: 195, column: 31}
						})('TODO');
				case 'Union':
					return A2(
						elm$core$String$join,
						'.',
						A2(
							author$project$Graphql$Generator$ModuleName$union,
							context,
							author$project$Graphql$Parser$ClassCaseName$build(refName)));
				default:
					return _Debug_todo(
						'Graphql.Generator.Field',
						{
							start: {line: 201, column: 21},
							end: {line: 201, column: 31}
						})('TODO');
			}
		}();
		var objectArgAnnotation = A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'SelectionSet decodesTo {0}',
			_List_fromArray(
				[typeLock]));
		return A2(
			author$project$Graphql$Generator$Field$prependArg,
			{annotation: objectArgAnnotation, arg: 'object_'},
			{
				annotatedArgs: _List_Nil,
				decoder: 'object_',
				decoderAnnotation: A2(author$project$Graphql$Generator$Decoder$generateType, apiSubmodule, typeRef),
				fieldArgs: _List_Nil,
				letBindings: _List_Nil,
				objectDecoderChain: elm$core$Maybe$Just(
					' (' + (A2(
						elm$core$String$join,
						' >> ',
						A2(author$project$Graphql$Generator$Decoder$generateDecoder, apiSubmodule, typeRef)) + ')')),
				otherThing: '.selectionField',
				typeAliases: _List_Nil
			});
	});
var author$project$Graphql$Generator$Field$init = F3(
	function (context, fieldName, typeRef) {
		var apiSubmodule = context.apiSubmodule;
		var referrableType = typeRef.a;
		var isNullable = typeRef.b;
		var _n0 = author$project$Graphql$Generator$Field$leafType(typeRef);
		switch (_n0.$) {
			case 'ObjectLeaf':
				var refName = _n0.a;
				return A4(author$project$Graphql$Generator$Field$objectThing, context, typeRef, refName, author$project$Graphql$Generator$Field$Object);
			case 'InterfaceLeaf':
				var refName = _n0.a;
				return A4(author$project$Graphql$Generator$Field$objectThing, context, typeRef, refName, author$project$Graphql$Generator$Field$Interface);
			case 'UnionLeaf':
				var refName = _n0.a;
				return A4(author$project$Graphql$Generator$Field$objectThing, context, typeRef, refName, author$project$Graphql$Generator$Field$Interface);
			case 'EnumLeaf':
				return A2(author$project$Graphql$Generator$Field$initScalarField, apiSubmodule, typeRef);
			default:
				return A2(author$project$Graphql$Generator$Field$initScalarField, apiSubmodule, typeRef);
		}
	});
var author$project$Graphql$Generator$Field$toFieldGenerator = F2(
	function (context, field) {
		var apiSubmodule = context.apiSubmodule;
		return A4(
			author$project$Graphql$Generator$Field$addOptionalArgs,
			field,
			apiSubmodule,
			field.args,
			A4(
				author$project$Graphql$Generator$Field$addRequiredArgs,
				field,
				apiSubmodule,
				field.args,
				A3(author$project$Graphql$Generator$Field$init, context, field.name, field.typeRef)));
	});
var author$project$Graphql$Generator$Field$generateForInterface = F3(
	function (context, thisObjectName, field) {
		return A4(
			author$project$Graphql$Generator$Field$forObject_,
			context,
			A2(
				author$project$Graphql$Generator$ModuleName$interface,
				context,
				author$project$Graphql$Parser$ClassCaseName$build(thisObjectName)),
			field,
			A2(author$project$Graphql$Generator$Field$toFieldGenerator, context, field));
	});
var author$project$Graphql$Generator$Interface$fragment = F3(
	function (context, moduleName, interfaceImplementor) {
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'on{0} : SelectionSet decodesTo {2} -> FragmentSelectionSet decodesTo {3}\non{0} (SelectionSet fields decoder) =\n    FragmentSelectionSet "{1}" fields decoder\n',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(interfaceImplementor),
					author$project$Graphql$Parser$ClassCaseName$raw(interfaceImplementor),
					A2(
					elm$core$String$join,
					'.',
					A2(author$project$Graphql$Generator$ModuleName$object, context, interfaceImplementor)),
					A2(elm$core$String$join, '.', moduleName)
				]));
	});
var author$project$Graphql$Generator$Interface$fragments = F3(
	function (context, implementors, moduleName) {
		return A2(
			elm$core$String$join,
			'\n\n',
			A2(
				elm$core$List$map,
				A2(author$project$Graphql$Generator$Interface$fragment, context, moduleName),
				implementors));
	});
var author$project$Graphql$Generator$Imports$getArgRefs = function (_n0) {
	var args = _n0.args;
	return A2(
		elm$core$List$map,
		function ($) {
			return $.typeRef;
		},
		args);
};
var elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3(elm$core$List$foldr, elm$core$List$cons, ys, xs);
		}
	});
var elm$core$List$concat = function (lists) {
	return A3(elm$core$List$foldr, elm$core$List$append, _List_Nil, lists);
};
var elm$core$List$concatMap = F2(
	function (f, list) {
		return elm$core$List$concat(
			A2(elm$core$List$map, f, list));
	});
var author$project$Graphql$Generator$Imports$allRefs = function (fields) {
	return _Utils_ap(
		A2(elm$core$List$concatMap, author$project$Graphql$Generator$Imports$getArgRefs, fields),
		A2(
			elm$core$List$map,
			function (_n0) {
				var typeRef = _n0.typeRef;
				return typeRef;
			},
			fields));
};
var author$project$Graphql$Generator$Imports$imports = F2(
	function (apiSubmodule, _n0) {
		imports:
		while (true) {
			var referrableType = _n0.a;
			var isNullable = _n0.b;
			switch (referrableType.$) {
				case 'Scalar':
					return elm$core$Maybe$Nothing;
				case 'List':
					var typeRef = referrableType.a;
					var $temp$apiSubmodule = apiSubmodule,
						$temp$_n0 = typeRef;
					apiSubmodule = $temp$apiSubmodule;
					_n0 = $temp$_n0;
					continue imports;
				case 'ObjectRef':
					var objectName = referrableType.a;
					return elm$core$Maybe$Nothing;
				case 'InterfaceRef':
					var interfaceName = referrableType.a;
					return elm$core$Maybe$Nothing;
				case 'EnumRef':
					var enumName = referrableType.a;
					return elm$core$Maybe$Just(
						A2(
							author$project$Graphql$Generator$ModuleName$enum,
							{apiSubmodule: apiSubmodule},
							enumName));
				case 'InputObjectRef':
					var inputObjectName = referrableType.a;
					return elm$core$Maybe$Nothing;
				default:
					var unionName = referrableType.a;
					return elm$core$Maybe$Nothing;
			}
		}
	});
var author$project$Graphql$Generator$Imports$importsWithoutSelf = F3(
	function (apiSubmodule, importingFrom, typeRefs) {
		return A2(
			elm$core$List$filter,
			function (moduleName) {
				return !_Utils_eq(moduleName, importingFrom);
			},
			A2(
				elm$core$List$filterMap,
				author$project$Graphql$Generator$Imports$imports(apiSubmodule),
				typeRefs));
	});
var author$project$Graphql$Generator$Imports$toImportString = function (moduleName) {
	return 'import ' + moduleName;
};
var author$project$Graphql$Generator$Imports$toModuleName = function (modulePath) {
	return A2(elm$core$String$join, '.', modulePath);
};
var author$project$Graphql$Generator$Imports$importsString = F3(
	function (apiSubmodule, importingFrom, typeRefs) {
		return A2(
			elm$core$String$join,
			'\n',
			A2(
				elm$core$List$map,
				author$project$Graphql$Generator$Imports$toImportString,
				A2(
					elm$core$List$map,
					author$project$Graphql$Generator$Imports$toModuleName,
					A3(
						author$project$Graphql$Generator$Imports$importsWithoutSelf,
						apiSubmodule,
						importingFrom,
						author$project$Graphql$Generator$Imports$allRefs(typeRefs)))));
	});
var author$project$Graphql$Generator$Interface$prepend = F3(
	function (_n0, moduleName, fields) {
		var apiSubmodule = _n0.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\nimport Graphql.Internal.Builder.Argument as Argument exposing (Argument)\nimport Graphql.Field as Field exposing (Field)\nimport Graphql.Internal.Builder.Object as Object\nimport Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))\nimport Graphql.OptionalArgument exposing (OptionalArgument(..))\nimport {2}.Object\nimport {2}.Interface\nimport {2}.Union\nimport {2}.Scalar\nimport {2}.InputObject\nimport Json.Decode as Decode\nimport Graphql.Internal.Encode as Encode exposing (Value)\n{1}\n\n{-| Select only common fields from the interface.\n-}\ncommonSelection : (a -> constructor) -> SelectionSet (a -> constructor) {0}\ncommonSelection constructor =\n    Object.selection constructor\n\n\n{-| Select both common and type-specific fields from the interface.\n-}\nselection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific {0}) -> SelectionSet (a -> constructor) {0}\nselection constructor typeSpecificDecoders =\n    Object.interfaceSelection typeSpecificDecoders constructor\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '.', moduleName),
					A3(author$project$Graphql$Generator$Imports$importsString, apiSubmodule, moduleName, fields),
					A2(elm$core$String$join, '.', apiSubmodule)
				]));
	});
var elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _n1 = A2(elm$core$Basics$compare, targetKey, key);
				switch (_n1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
						return elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var author$project$Graphql$Generator$Interface$generate = F4(
	function (context, name, moduleName, fields) {
		return _Utils_ap(
			A3(author$project$Graphql$Generator$Interface$prepend, context, moduleName, fields),
			_Utils_ap(
				A3(
					author$project$Graphql$Generator$Interface$fragments,
					context,
					A2(
						elm$core$Maybe$withDefault,
						_List_Nil,
						A2(elm$core$Dict$get, name, context.interfaces)),
					moduleName),
				A2(
					elm$core$String$join,
					'\n\n',
					A2(
						elm$core$List$map,
						A2(author$project$Graphql$Generator$Field$generateForInterface, context, name),
						fields))));
	});
var author$project$Graphql$Generator$ModuleName$mutation = function (_n0) {
	var apiSubmodule = _n0.apiSubmodule;
	return _Utils_ap(
		apiSubmodule,
		_List_fromArray(
			['Mutation']));
};
var author$project$Graphql$Generator$ModuleName$query = function (_n0) {
	var apiSubmodule = _n0.apiSubmodule;
	return _Utils_ap(
		apiSubmodule,
		_List_fromArray(
			['Query']));
};
var author$project$Graphql$Generator$ModuleName$subscription = function (_n0) {
	var apiSubmodule = _n0.apiSubmodule;
	return _Utils_ap(
		apiSubmodule,
		_List_fromArray(
			['Subscription']));
};
var author$project$Graphql$Generator$ModuleName$generate = F2(
	function (context, _n0) {
		var name = _n0.a;
		var definableType = _n0.b;
		var description = _n0.c;
		switch (definableType.$) {
			case 'ObjectType':
				var fields = definableType.a;
				return _Utils_eq(name, context.query) ? author$project$Graphql$Generator$ModuleName$query(context) : (_Utils_eq(
					elm$core$Maybe$Just(name),
					context.mutation) ? author$project$Graphql$Generator$ModuleName$mutation(context) : (_Utils_eq(
					elm$core$Maybe$Just(name),
					context.subscription) ? author$project$Graphql$Generator$ModuleName$subscription(context) : A2(author$project$Graphql$Generator$ModuleName$object, context, name)));
			case 'ScalarType':
				return _List_Nil;
			case 'EnumType':
				var enumValues = definableType.a;
				return A2(author$project$Graphql$Generator$ModuleName$enum, context, name);
			case 'InterfaceType':
				var fields = definableType.a;
				var possibleTypes = definableType.b;
				return A2(author$project$Graphql$Generator$ModuleName$interface, context, name);
			case 'UnionType':
				var possibleTypes = definableType.a;
				return A2(author$project$Graphql$Generator$ModuleName$union, context, name);
			default:
				return A2(author$project$Graphql$Generator$ModuleName$inputObject, context, name);
		}
	});
var author$project$Graphql$Generator$Field$generateForObject = F3(
	function (context, thisObjectName, field) {
		return A4(
			author$project$Graphql$Generator$Field$forObject_,
			context,
			A2(author$project$Graphql$Generator$ModuleName$object, context, thisObjectName),
			field,
			A2(author$project$Graphql$Generator$Field$toFieldGenerator, context, field));
	});
var author$project$Graphql$Generator$StaticImports$all = function (_n0) {
	var apiSubmodule = _n0.apiSubmodule;
	return A2(
		lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
		'import Graphql.Internal.Builder.Argument as Argument exposing (Argument)\nimport Graphql.Field as Field exposing (Field)\nimport Graphql.Internal.Builder.Object as Object\nimport Graphql.Internal.Encode as Encode exposing (Value)\nimport Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)\nimport Graphql.OptionalArgument exposing (OptionalArgument(..))\nimport Graphql.SelectionSet exposing (SelectionSet)\nimport Json.Decode as Decode exposing (Decoder)\nimport {0}.Object\nimport {0}.Interface\nimport {0}.Union\nimport {0}.Scalar\nimport {0}.InputObject\nimport Graphql.Internal.Builder.Object as Object\nimport Graphql.OptionalArgument exposing (OptionalArgument(..))\nimport Graphql.SelectionSet exposing (SelectionSet)\nimport Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)\nimport Json.Decode as Decode exposing (Decoder)\nimport Graphql.Internal.Encode as Encode exposing (Value)',
		_List_fromArray(
			[
				A2(elm$core$String$join, '.', apiSubmodule)
			]));
};
var author$project$Graphql$Generator$Mutation$prepend = F3(
	function (context, moduleName, fields) {
		var apiSubmodule = context.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\n{2}\n{1}\n\n\n{-| Select fields to build up a top-level mutation. The request can be sent with\nfunctions from `Graphql.Http`.\n-}\nselection : (a -> constructor) -> SelectionSet (a -> constructor) RootMutation\nselection constructor =\n    Object.selection constructor\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '.', moduleName),
					A3(author$project$Graphql$Generator$Imports$importsString, apiSubmodule, moduleName, fields),
					author$project$Graphql$Generator$StaticImports$all(context)
				]));
	});
var author$project$Graphql$Generator$Mutation$generate = F3(
	function (context, moduleName, fields) {
		return _Utils_ap(
			A3(author$project$Graphql$Generator$Mutation$prepend, context, moduleName, fields),
			A2(
				elm$core$String$join,
				'\n\n',
				A2(
					elm$core$List$map,
					A2(
						author$project$Graphql$Generator$Field$generateForObject,
						context,
						A2(
							elm$core$Maybe$withDefault,
							author$project$Graphql$Parser$ClassCaseName$build(''),
							context.mutation)),
					fields)));
	});
var author$project$Graphql$Generator$Object$prepend = F3(
	function (_n0, moduleName, fields) {
		var apiSubmodule = _n0.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\nimport Graphql.Internal.Builder.Argument as Argument exposing (Argument)\nimport Graphql.Field as Field exposing (Field)\nimport Graphql.Internal.Builder.Object as Object\nimport Graphql.SelectionSet exposing (SelectionSet)\nimport Graphql.OptionalArgument exposing (OptionalArgument(..))\nimport {2}.Object\nimport {2}.Interface\nimport {2}.Union\nimport {2}.Scalar\nimport {2}.InputObject\nimport Json.Decode as Decode\nimport Graphql.Internal.Encode as Encode exposing (Value)\n{1}\n\n\n{-| Select fields to build up a SelectionSet for this object.\n-}\nselection : (a -> constructor) -> SelectionSet (a -> constructor) {0}\nselection constructor =\n    Object.selection constructor\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '.', moduleName),
					A3(author$project$Graphql$Generator$Imports$importsString, apiSubmodule, moduleName, fields),
					A2(elm$core$String$join, '.', apiSubmodule)
				]));
	});
var author$project$Graphql$Generator$Object$generate = F4(
	function (context, name, moduleName, fields) {
		return _Utils_ap(
			A3(author$project$Graphql$Generator$Object$prepend, context, moduleName, fields),
			A2(
				elm$core$String$join,
				'\n\n',
				A2(
					elm$core$List$map,
					A2(author$project$Graphql$Generator$Field$generateForObject, context, name),
					fields)));
	});
var author$project$Graphql$Generator$Query$prepend = F3(
	function (context, moduleName, fields) {
		var apiSubmodule = context.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\n{2}\n{1}\n\n\n{-| Select fields to build up a top-level query. The request can be sent with\nfunctions from `Graphql.Http`.\n-}\nselection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery\nselection constructor =\n    Object.selection constructor\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '.', moduleName),
					A3(author$project$Graphql$Generator$Imports$importsString, apiSubmodule, moduleName, fields),
					author$project$Graphql$Generator$StaticImports$all(context)
				]));
	});
var author$project$Graphql$Generator$Query$generate = F3(
	function (context, moduleName, fields) {
		return _Utils_ap(
			A3(author$project$Graphql$Generator$Query$prepend, context, moduleName, fields),
			A2(
				elm$core$String$join,
				'\n\n',
				A2(
					elm$core$List$map,
					A2(author$project$Graphql$Generator$Field$generateForObject, context, context.query),
					fields)));
	});
var author$project$Graphql$Generator$Subscription$prepend = F3(
	function (context, moduleName, fields) {
		var apiSubmodule = context.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\n{2}\n{1}\n\n\n{-| Select fields to build up a top-level mutation. The request can be sent with\nfunctions from `Graphql.Http`.\n-}\nselection : (a -> constructor) -> SelectionSet (a -> constructor) RootSubscription\nselection constructor =\n    Object.selection constructor\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '.', moduleName),
					A3(author$project$Graphql$Generator$Imports$importsString, apiSubmodule, moduleName, fields),
					author$project$Graphql$Generator$StaticImports$all(context)
				]));
	});
var author$project$Graphql$Generator$Subscription$generate = F3(
	function (context, moduleName, fields) {
		return _Utils_ap(
			A3(author$project$Graphql$Generator$Subscription$prepend, context, moduleName, fields),
			A2(
				elm$core$String$join,
				'\n\n',
				A2(
					elm$core$List$map,
					A2(
						author$project$Graphql$Generator$Field$generateForObject,
						context,
						A2(
							elm$core$Maybe$withDefault,
							author$project$Graphql$Parser$ClassCaseName$build(''),
							context.subscription)),
					fields)));
	});
var author$project$Graphql$Generator$Union$fragment = F3(
	function (context, moduleName, interfaceImplementor) {
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'on{0} : SelectionSet decodesTo {2} -> FragmentSelectionSet decodesTo {3}\non{0} (SelectionSet fields decoder) =\n    FragmentSelectionSet "{1}" fields decoder\n',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(interfaceImplementor),
					author$project$Graphql$Parser$ClassCaseName$raw(interfaceImplementor),
					A2(
					elm$core$String$join,
					'.',
					A2(author$project$Graphql$Generator$ModuleName$object, context, interfaceImplementor)),
					A2(elm$core$String$join, '.', moduleName)
				]));
	});
var author$project$Graphql$Generator$Union$fragments = F3(
	function (context, implementors, moduleName) {
		return A2(
			elm$core$String$join,
			'\n\n',
			A2(
				elm$core$List$map,
				A2(author$project$Graphql$Generator$Union$fragment, context, moduleName),
				implementors));
	});
var author$project$Graphql$Generator$Union$prepend = F2(
	function (_n0, moduleName) {
		var apiSubmodule = _n0.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\nimport Graphql.Internal.Builder.Argument as Argument exposing (Argument)\nimport Graphql.Field as Field exposing (Field)\nimport Graphql.Internal.Builder.Object as Object\nimport Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))\nimport Graphql.OptionalArgument exposing (OptionalArgument(..))\nimport {1}.Object\nimport {1}.Interface\nimport {1}.Union\nimport {1}.Scalar\nimport {1}.InputObject\nimport Json.Decode as Decode\nimport Graphql.Internal.Encode as Encode exposing (Value)\n\n\nselection : (Maybe typeSpecific -> constructor) -> List (FragmentSelectionSet typeSpecific {0}) -> SelectionSet constructor {0}\nselection constructor typeSpecificDecoders =\n    Object.unionSelection typeSpecificDecoders constructor\n',
			_List_fromArray(
				[
					A2(elm$core$String$join, '.', moduleName),
					A2(elm$core$String$join, '.', apiSubmodule)
				]));
	});
var author$project$Graphql$Generator$Union$generate = F4(
	function (context, name, moduleName, possibleTypes) {
		return _Utils_ap(
			A2(author$project$Graphql$Generator$Union$prepend, context, moduleName),
			A3(author$project$Graphql$Generator$Union$fragments, context, possibleTypes, moduleName));
	});
var author$project$Graphql$Generator$Group$toPair = F2(
	function (context, definition) {
		var name = definition.a;
		var definableType = definition.b;
		var description = definition.c;
		var moduleName = A2(author$project$Graphql$Generator$ModuleName$generate, context, definition);
		return A2(
			elm$core$Maybe$map,
			function (fileContents) {
				return _Utils_Tuple2(moduleName, fileContents);
			},
			function () {
				switch (definableType.$) {
					case 'ObjectType':
						var fields = definableType.a;
						return _Utils_eq(name, context.query) ? elm$core$Maybe$Just(
							A3(author$project$Graphql$Generator$Query$generate, context, moduleName, fields)) : (_Utils_eq(
							elm$core$Maybe$Just(name),
							context.mutation) ? elm$core$Maybe$Just(
							A3(author$project$Graphql$Generator$Mutation$generate, context, moduleName, fields)) : (_Utils_eq(
							elm$core$Maybe$Just(name),
							context.subscription) ? elm$core$Maybe$Just(
							A3(author$project$Graphql$Generator$Subscription$generate, context, moduleName, fields)) : elm$core$Maybe$Just(
							A4(author$project$Graphql$Generator$Object$generate, context, name, moduleName, fields))));
					case 'ScalarType':
						return elm$core$Maybe$Nothing;
					case 'EnumType':
						var enumValues = definableType.a;
						return elm$core$Maybe$Just(
							A4(author$project$Graphql$Generator$Enum$generate, name, moduleName, enumValues, description));
					case 'InterfaceType':
						var fields = definableType.a;
						var possibleTypes = definableType.b;
						return elm$core$Maybe$Just(
							A4(
								author$project$Graphql$Generator$Interface$generate,
								context,
								author$project$Graphql$Parser$ClassCaseName$raw(name),
								moduleName,
								fields));
					case 'UnionType':
						var possibleTypes = definableType.a;
						return elm$core$Maybe$Just(
							A4(author$project$Graphql$Generator$Union$generate, context, name, moduleName, possibleTypes));
					default:
						var fields = definableType.a;
						return elm$core$Maybe$Nothing;
				}
			}());
	});
var author$project$Graphql$Generator$Decoder$generateEncoderLowLevel = F2(
	function (apiSubmodule, referrableType) {
		return A3(
			author$project$Graphql$Generator$Decoder$generateEncoder_,
			true,
			apiSubmodule,
			A2(author$project$Graphql$Parser$Type$TypeReference, referrableType, author$project$Graphql$Parser$Type$NonNullable));
	});
var author$project$Graphql$Generator$InputObjectFile$encoderFunction = F2(
	function (_n0, field) {
		var apiSubmodule = _n0.apiSubmodule;
		var _n1 = field.typeRef;
		var referrableType = _n1.a;
		var isNullable = _n1.b;
		var filledOptionalsRecord_ = function () {
			if (isNullable.$ === 'NonNullable') {
				return A2(
					lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
					' input.{0} |> Just',
					_List_fromArray(
						[
							author$project$Graphql$Parser$CamelCaseName$normalized(field.name)
						]));
			} else {
				return A2(
					lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
					' |> Encode.optional input.{0}',
					_List_fromArray(
						[
							author$project$Graphql$Parser$CamelCaseName$normalized(field.name)
						]));
			}
		}();
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'({0}) {1}',
			_List_fromArray(
				[
					A2(author$project$Graphql$Generator$Decoder$generateEncoderLowLevel, apiSubmodule, referrableType),
					filledOptionalsRecord_
				]));
	});
var author$project$Graphql$Generator$InputObjectFile$encoderForField = F2(
	function (context, field) {
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'( "{0}", {1} )',
			_List_fromArray(
				[
					author$project$Graphql$Parser$CamelCaseName$raw(field.name),
					A2(author$project$Graphql$Generator$InputObjectFile$encoderFunction, context, field)
				]));
	});
var author$project$Graphql$Generator$InputObjectFile$encoder = F2(
	function (context, _n0) {
		var name = _n0.name;
		var fields = _n0.fields;
		var hasLoop = _n0.hasLoop;
		var parameter = hasLoop ? A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'({0} input)',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(name)
				])) : 'input';
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{-| Encode a {0} into a value that can be used as an argument.\n-}\nencode{0} : {0} -> Value\nencode{0} {1} =\n    Encode.maybeObject\n        [ {2} ]',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(name),
					parameter,
					A2(
					elm$core$String$join,
					', ',
					A2(
						elm$core$List$map,
						author$project$Graphql$Generator$InputObjectFile$encoderForField(context),
						fields))
				]));
	});
var author$project$Graphql$Generator$Decoder$generateTypeForInputObject = F2(
	function (apiSubmodule, typeRef) {
		return A4(author$project$Graphql$Generator$Decoder$generateTypeCommon, true, 'OptionalArgument', apiSubmodule, typeRef);
	});
var author$project$Graphql$Generator$InputObjectFile$aliasEntry = F2(
	function (_n0, field) {
		var apiSubmodule = _n0.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{0} : {1}',
			_List_fromArray(
				[
					author$project$Graphql$Parser$CamelCaseName$normalized(field.name),
					A2(author$project$Graphql$Generator$Decoder$generateTypeForInputObject, apiSubmodule, field.typeRef)
				]));
	});
var author$project$Graphql$Generator$InputObjectFile$typeAlias = F2(
	function (context, _n0) {
		var name = _n0.name;
		var fields = _n0.fields;
		var hasLoop = _n0.hasLoop;
		return hasLoop ? A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{-| Type alias for the `{0}` attributes. Note that this type\nneeds to use the `{0}` type (not just a plain type alias) because it has\nreferences to itself either directly (recursive) or indirectly (circular). See\n<https://github.com/dillonkearns/elm-graphql/issues/33>.\n-}\ntype alias {0}Raw =\n    { {1} }\n\n\n{-| Type for the {0} input object.\n-}\ntype {0}\n    = {0} {0}Raw\n    ',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(name),
					A2(
					elm$core$String$join,
					', ',
					A2(
						elm$core$List$map,
						author$project$Graphql$Generator$InputObjectFile$aliasEntry(context),
						fields))
				])) : A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{-| Type for the {0} input object.\n-}\ntype alias {0} =\n    { {1} }\n    ',
			_List_fromArray(
				[
					author$project$Graphql$Parser$ClassCaseName$normalized(name),
					A2(
					elm$core$String$join,
					', ',
					A2(
						elm$core$List$map,
						author$project$Graphql$Generator$InputObjectFile$aliasEntry(context),
						fields))
				]));
	});
var author$project$Graphql$Generator$AnnotatedArg$AnnotatedArgs = F2(
	function (args, returnAnnotation) {
		return {args: args, returnAnnotation: returnAnnotation};
	});
var author$project$Graphql$Generator$AnnotatedArg$buildWithArgs = F2(
	function (args, returnAnnotation) {
		return A2(author$project$Graphql$Generator$AnnotatedArg$AnnotatedArgs, args, returnAnnotation);
	});
var elm$core$Tuple$second = function (_n0) {
	var y = _n0.b;
	return y;
};
var author$project$Graphql$Generator$AnnotatedArg$toString = F2(
	function (functionName, _n0) {
		var args = _n0.args;
		var returnAnnotation = _n0.returnAnnotation;
		var parameterNames = A2(elm$core$List$map, elm$core$Tuple$second, args);
		var annotations = _Utils_ap(
			A2(elm$core$List$map, elm$core$Tuple$first, args),
			_List_fromArray(
				[returnAnnotation]));
		var typeAnnotation = A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{0} : {1}',
			_List_fromArray(
				[
					functionName,
					A2(elm$core$String$join, ' -> ', annotations)
				]));
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{0}\n{1} {2} =\n',
			_List_fromArray(
				[
					typeAnnotation,
					functionName,
					A2(elm$core$String$join, ' ', parameterNames)
				]));
	});
var author$project$Graphql$Generator$InputObjectFile$Constructor$compact = elm$core$List$filterMap(elm$core$Basics$identity);
var author$project$Graphql$Generator$InputObjectFile$Constructor$aliasEntry = F2(
	function (_n0, field) {
		var apiSubmodule = _n0.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{0} : {1}',
			_List_fromArray(
				[
					author$project$Graphql$Parser$CamelCaseName$normalized(field.name),
					A2(author$project$Graphql$Generator$Decoder$generateTypeForInputObject, apiSubmodule, field.typeRef)
				]));
	});
var elm$core$List$length = function (xs) {
	return A3(
		elm$core$List$foldl,
		F2(
			function (_n0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var author$project$Graphql$Generator$InputObjectFile$Constructor$constructorFieldsAlias = F3(
	function (nameThing, context, fields) {
		return (elm$core$List$length(fields) > 0) ? A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'type alias {0} =\n    { {1} }',
			_List_fromArray(
				[
					nameThing,
					A2(
					elm$core$String$join,
					', ',
					A2(
						elm$core$List$map,
						author$project$Graphql$Generator$InputObjectFile$Constructor$aliasEntry(context),
						fields))
				])) : '';
	});
var author$project$Graphql$Generator$InputObjectFile$Constructor$filledOptionalsRecord = function (optionalFields) {
	return A2(
		elm$core$String$join,
		', ',
		A2(
			elm$core$List$map,
			function (fieldName) {
				return author$project$Graphql$Parser$CamelCaseName$normalized(fieldName) + ' = Absent';
			},
			A2(
				elm$core$List$map,
				function ($) {
					return $.name;
				},
				optionalFields)));
};
var author$project$Graphql$Generator$InputObjectFile$Constructor$when = F2(
	function (condition, value) {
		return condition ? elm$core$Maybe$Just(value) : elm$core$Maybe$Nothing;
	});
var author$project$Graphql$Parser$Type$Nullable = {$: 'Nullable'};
var author$project$Graphql$Generator$InputObjectFile$Constructor$generate = F2(
	function (context, _n0) {
		var name = _n0.name;
		var fields = _n0.fields;
		var hasLoop = _n0.hasLoop;
		var returnRecord = A2(
			elm$core$String$join,
			', ',
			A2(
				elm$core$List$map,
				function (field) {
					return A2(
						lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
						'{0} = {1}.{0}',
						_List_fromArray(
							[
								author$project$Graphql$Parser$CamelCaseName$normalized(field.name),
								function () {
								var _n3 = field.typeRef;
								var referrableType = _n3.a;
								var isNullable = _n3.b;
								if (isNullable.$ === 'Nullable') {
									return 'optionals';
								} else {
									return 'required';
								}
							}()
							]));
				},
				fields));
		var requiredFields = A2(
			elm$core$List$filter,
			function (field) {
				var _n2 = field.typeRef;
				var referrableType = _n2.a;
				var isNullable = _n2.b;
				return _Utils_eq(isNullable, author$project$Graphql$Parser$Type$NonNullable);
			},
			fields);
		var optionalFields = A2(
			elm$core$List$filter,
			function (field) {
				var _n1 = field.typeRef;
				var referrableType = _n1.a;
				var isNullable = _n1.b;
				return _Utils_eq(isNullable, author$project$Graphql$Parser$Type$Nullable);
			},
			fields);
		var letClause = author$project$Graphql$Generator$Let$generate(
			author$project$Graphql$Generator$InputObjectFile$Constructor$compact(
				_List_fromArray(
					[
						A2(
						author$project$Graphql$Generator$InputObjectFile$Constructor$when,
						elm$core$List$length(optionalFields) > 0,
						_Utils_Tuple2(
							'optionals',
							A2(
								lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
								'\n            fillOptionals\n                { {0} }',
								_List_fromArray(
									[
										author$project$Graphql$Generator$InputObjectFile$Constructor$filledOptionalsRecord(optionalFields)
									]))))
					])));
		var annotation = A2(
			author$project$Graphql$Generator$AnnotatedArg$toString,
			'build' + author$project$Graphql$Parser$ClassCaseName$normalized(name),
			A2(
				author$project$Graphql$Generator$AnnotatedArg$buildWithArgs,
				author$project$Graphql$Generator$InputObjectFile$Constructor$compact(
					_List_fromArray(
						[
							A2(
							author$project$Graphql$Generator$InputObjectFile$Constructor$when,
							elm$core$List$length(requiredFields) > 0,
							_Utils_Tuple2(
								A2(
									lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
									'{0}RequiredFields',
									_List_fromArray(
										[
											author$project$Graphql$Parser$ClassCaseName$normalized(name)
										])),
								'required')),
							A2(
							author$project$Graphql$Generator$InputObjectFile$Constructor$when,
							elm$core$List$length(optionalFields) > 0,
							_Utils_Tuple2(
								A2(
									lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
									'({0}OptionalFields -> {0}OptionalFields)',
									_List_fromArray(
										[
											author$project$Graphql$Parser$ClassCaseName$normalized(name)
										])),
								'fillOptionals'))
						])),
				author$project$Graphql$Parser$ClassCaseName$normalized(name)));
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'{0}{1}\n    {2}{ {3} }\n\n{4}\n{5}\n',
			_List_fromArray(
				[
					annotation,
					letClause,
					hasLoop ? author$project$Graphql$Parser$ClassCaseName$normalized(name) : '',
					returnRecord,
					A3(
					author$project$Graphql$Generator$InputObjectFile$Constructor$constructorFieldsAlias,
					author$project$Graphql$Parser$ClassCaseName$normalized(name) + 'RequiredFields',
					context,
					requiredFields),
					A3(
					author$project$Graphql$Generator$InputObjectFile$Constructor$constructorFieldsAlias,
					author$project$Graphql$Parser$ClassCaseName$normalized(name) + 'OptionalFields',
					context,
					optionalFields)
				]));
	});
var author$project$Graphql$Generator$InputObjectFile$generateEncoderAndAlias = F2(
	function (context, inputObjectDetails) {
		return A2(
			elm$core$String$join,
			'\n\n',
			_List_fromArray(
				[
					A2(author$project$Graphql$Generator$InputObjectFile$Constructor$generate, context, inputObjectDetails),
					A2(author$project$Graphql$Generator$InputObjectFile$typeAlias, context, inputObjectDetails),
					A2(author$project$Graphql$Generator$InputObjectFile$encoder, context, inputObjectDetails)
				]));
	});
var author$project$Graphql$Generator$InputObjectFile$moduleName = function (_n0) {
	var apiSubmodule = _n0.apiSubmodule;
	return _Utils_ap(
		apiSubmodule,
		_List_fromArray(
			['InputObject']));
};
var author$project$Graphql$Generator$InputObjectFile$generateImports = F2(
	function (context, fields) {
		var apiSubmodule = context.apiSubmodule;
		return A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'import Graphql.Internal.Builder.Argument as Argument exposing (Argument)\nimport Graphql.Field as Field exposing (Field)\nimport Graphql.Internal.Builder.Object as Object\nimport Graphql.SelectionSet exposing (SelectionSet)\nimport Graphql.OptionalArgument exposing (OptionalArgument(..))\nimport {1}.Object\nimport {1}.Interface\nimport {1}.Union\nimport {1}.Scalar\nimport Json.Decode as Decode\nimport Graphql.Internal.Encode as Encode exposing (Value)\n{0}\n',
			_List_fromArray(
				[
					A3(
					author$project$Graphql$Generator$Imports$importsString,
					apiSubmodule,
					author$project$Graphql$Generator$InputObjectFile$moduleName(context),
					fields),
					A2(elm$core$String$join, '.', apiSubmodule)
				]));
	});
var author$project$Graphql$Generator$InputObjectLoops$hasRecursiveRef = F2(
	function (inputObjectName, referrableType) {
		hasRecursiveRef:
		while (true) {
			switch (referrableType.$) {
				case 'InputObjectRef':
					var referredInputObjectName = referrableType.a;
					return _Utils_eq(inputObjectName, referredInputObjectName);
				case 'List':
					var listTypeRef = referrableType.a;
					var listType = listTypeRef.a;
					var isNullable = listTypeRef.b;
					var $temp$inputObjectName = inputObjectName,
						$temp$referrableType = listType;
					inputObjectName = $temp$inputObjectName;
					referrableType = $temp$referrableType;
					continue hasRecursiveRef;
				case 'Scalar':
					return false;
				case 'EnumRef':
					return false;
				case 'ObjectRef':
					return false;
				case 'UnionRef':
					return false;
				default:
					return false;
			}
		}
	});
var author$project$Graphql$Generator$InputObjectLoops$fieldIsRecursive = F2(
	function (inputObjectName, field) {
		var _n0 = field.typeRef;
		var referrableType = _n0.a;
		var isNullable = _n0.b;
		return A2(author$project$Graphql$Generator$InputObjectLoops$hasRecursiveRef, inputObjectName, referrableType);
	});
var author$project$Graphql$Generator$InputObjectLoops$isRecursive = F2(
	function (inputObjectName, fields) {
		return A2(
			elm$core$List$any,
			author$project$Graphql$Generator$InputObjectLoops$fieldIsRecursive(inputObjectName),
			fields);
	});
var author$project$Graphql$Generator$InputObjectLoops$lookupInputObject = F2(
	function (typeDefs, inputObjectName) {
		return elm$core$List$head(
			A2(
				elm$core$List$filterMap,
				function (_n0) {
					var name = _n0.a;
					var definableType = _n0.b;
					var description = _n0.c;
					if (definableType.$ === 'InputObjectType') {
						var fields = definableType.a;
						return _Utils_eq(name, inputObjectName) ? elm$core$Maybe$Just(
							_Utils_Tuple2(name, fields)) : elm$core$Maybe$Nothing;
					} else {
						return elm$core$Maybe$Nothing;
					}
				},
				typeDefs));
	});
var elm$core$Set$Set_elm_builtin = function (a) {
	return {$: 'Set_elm_builtin', a: a};
};
var elm$core$Set$empty = elm$core$Set$Set_elm_builtin(elm$core$Dict$empty);
var elm$core$Set$insert = F2(
	function (key, _n0) {
		var dict = _n0.a;
		return elm$core$Set$Set_elm_builtin(
			A3(elm$core$Dict$insert, key, _Utils_Tuple0, dict));
	});
var elm$core$Dict$member = F2(
	function (key, dict) {
		var _n0 = A2(elm$core$Dict$get, key, dict);
		if (_n0.$ === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var elm$core$Set$member = F2(
	function (key, _n0) {
		var dict = _n0.a;
		return A2(elm$core$Dict$member, key, dict);
	});
var elm_community$list_extra$List$Extra$uniqueHelp = F4(
	function (f, existing, remaining, accumulator) {
		uniqueHelp:
		while (true) {
			if (!remaining.b) {
				return elm$core$List$reverse(accumulator);
			} else {
				var first = remaining.a;
				var rest = remaining.b;
				var computedFirst = f(first);
				if (A2(elm$core$Set$member, computedFirst, existing)) {
					var $temp$f = f,
						$temp$existing = existing,
						$temp$remaining = rest,
						$temp$accumulator = accumulator;
					f = $temp$f;
					existing = $temp$existing;
					remaining = $temp$remaining;
					accumulator = $temp$accumulator;
					continue uniqueHelp;
				} else {
					var $temp$f = f,
						$temp$existing = A2(elm$core$Set$insert, computedFirst, existing),
						$temp$remaining = rest,
						$temp$accumulator = A2(elm$core$List$cons, first, accumulator);
					f = $temp$f;
					existing = $temp$existing;
					remaining = $temp$remaining;
					accumulator = $temp$accumulator;
					continue uniqueHelp;
				}
			}
		}
	});
var elm_community$list_extra$List$Extra$uniqueBy = F2(
	function (f, list) {
		return A4(elm_community$list_extra$List$Extra$uniqueHelp, f, elm$core$Set$empty, list, _List_Nil);
	});
var elm_community$list_extra$List$Extra$allDifferentBy = F2(
	function (f, list) {
		return _Utils_eq(
			elm$core$List$length(list),
			elm$core$List$length(
				A2(elm_community$list_extra$List$Extra$uniqueBy, f, list)));
	});
var elm_community$list_extra$List$Extra$allDifferent = function (list) {
	return A2(elm_community$list_extra$List$Extra$allDifferentBy, elm$core$Basics$identity, list);
};
var author$project$Graphql$Generator$InputObjectLoops$fieldIsCircular_ = F4(
	function (visitedNames, typeDefs, inputObjectName, fieldTypeRef) {
		fieldIsCircular_:
		while (true) {
			var alreadyVisitedThis = elm_community$list_extra$List$Extra$allDifferent(
				A2(elm$core$List$map, author$project$Graphql$Parser$ClassCaseName$raw, visitedNames));
			var referrableType = fieldTypeRef.a;
			var isNullable = fieldTypeRef.b;
			switch (referrableType.$) {
				case 'InputObjectRef':
					var inputObjectRefName = referrableType.a;
					var _n2 = A2(author$project$Graphql$Generator$InputObjectLoops$lookupInputObject, typeDefs, inputObjectRefName);
					if (_n2.$ === 'Just') {
						var _n3 = _n2.a;
						var name = _n3.a;
						var fields = _n3.b;
						return (!alreadyVisitedThis) || (A2(author$project$Graphql$Generator$InputObjectLoops$isRecursive, inputObjectName, fields) || A2(
							elm$core$List$any,
							A3(
								author$project$Graphql$Generator$InputObjectLoops$fieldIsCircular_,
								A2(elm$core$List$cons, inputObjectName, visitedNames),
								typeDefs,
								inputObjectName),
							A2(
								elm$core$List$map,
								function ($) {
									return $.typeRef;
								},
								fields)));
					} else {
						return false;
					}
				case 'List':
					var listTypeRef = referrableType.a;
					var $temp$visitedNames = A2(elm$core$List$cons, inputObjectName, visitedNames),
						$temp$typeDefs = typeDefs,
						$temp$inputObjectName = inputObjectName,
						$temp$fieldTypeRef = listTypeRef;
					visitedNames = $temp$visitedNames;
					typeDefs = $temp$typeDefs;
					inputObjectName = $temp$inputObjectName;
					fieldTypeRef = $temp$fieldTypeRef;
					continue fieldIsCircular_;
				default:
					return false;
			}
		}
	});
var author$project$Graphql$Generator$InputObjectLoops$fieldIsCircular = F3(
	function (typeDefs, inputObjectName, fieldTypeRef) {
		return A4(author$project$Graphql$Generator$InputObjectLoops$fieldIsCircular_, _List_Nil, typeDefs, inputObjectName, fieldTypeRef);
	});
var author$project$Graphql$Generator$InputObjectLoops$hasLoop = F2(
	function (typeDefs, _n0) {
		var name = _n0.a;
		var definableType = _n0.b;
		var description = _n0.c;
		if (definableType.$ === 'InputObjectType') {
			var fields = definableType.a;
			return A2(
				elm$core$List$any,
				A2(author$project$Graphql$Generator$InputObjectLoops$fieldIsCircular, typeDefs, name),
				A2(
					elm$core$List$map,
					function ($) {
						return $.typeRef;
					},
					fields));
		} else {
			return false;
		}
	});
var author$project$Graphql$Generator$InputObjectFile$isInputObject = F2(
	function (typeDefs, typeDef) {
		var name = typeDef.a;
		var definableType = typeDef.b;
		var description = typeDef.c;
		if (definableType.$ === 'InputObjectType') {
			var fields = definableType.a;
			return elm$core$Maybe$Just(
				{
					definableType: definableType,
					fields: fields,
					hasLoop: A2(author$project$Graphql$Generator$InputObjectLoops$hasLoop, typeDefs, typeDef),
					name: name
				});
		} else {
			return elm$core$Maybe$Nothing;
		}
	});
var author$project$Graphql$Generator$InputObjectFile$generateFileContents = F2(
	function (context, typeDefinitions) {
		var typesToGenerate = A2(
			elm$core$List$filterMap,
			author$project$Graphql$Generator$InputObjectFile$isInputObject(typeDefinitions),
			typeDefinitions);
		var fields = A2(
			elm$core$List$concatMap,
			function ($) {
				return $.fields;
			},
			typesToGenerate);
		return _Utils_eq(typesToGenerate, _List_Nil) ? A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    ""\n',
			_List_fromArray(
				[
					A2(
					elm$core$String$join,
					'.',
					author$project$Graphql$Generator$InputObjectFile$moduleName(context))
				])) : A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\n\n{1}\n\n\n{2}\n',
			_List_fromArray(
				[
					A2(
					elm$core$String$join,
					'.',
					author$project$Graphql$Generator$InputObjectFile$moduleName(context)),
					A2(author$project$Graphql$Generator$InputObjectFile$generateImports, context, fields),
					A2(
					elm$core$String$join,
					'\n\n\n',
					A2(
						elm$core$List$map,
						author$project$Graphql$Generator$InputObjectFile$generateEncoderAndAlias(context),
						typesToGenerate))
				]));
	});
var author$project$Graphql$Generator$InputObjectFile$generate = F2(
	function (context, typeDefinitions) {
		return _Utils_Tuple2(
			author$project$Graphql$Generator$InputObjectFile$moduleName(context),
			A2(author$project$Graphql$Generator$InputObjectFile$generateFileContents, context, typeDefinitions));
	});
var author$project$Graphql$Generator$Scalar$generateType = function (name) {
	return A2(
		lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
		'type {0}\n    = {0} String',
		_List_fromArray(
			[
				author$project$Graphql$Parser$ClassCaseName$normalized(name)
			]));
};
var author$project$Graphql$Generator$Scalar$builtInNames = _List_fromArray(
	['Boolean', 'String', 'Int', 'Float']);
var author$project$Graphql$Generator$Scalar$isBuiltIn = function (name) {
	return A2(
		elm$core$List$member,
		author$project$Graphql$Parser$ClassCaseName$raw(name),
		author$project$Graphql$Generator$Scalar$builtInNames);
};
var author$project$Graphql$Generator$Scalar$isScalar = function (definableType) {
	if (definableType.$ === 'ScalarType') {
		return true;
	} else {
		return false;
	}
};
var elm$core$Basics$and = _Basics_and;
var author$project$Graphql$Generator$Scalar$include = function (_n0) {
	var name = _n0.a;
	var definableType = _n0.b;
	var description = _n0.c;
	return author$project$Graphql$Generator$Scalar$isScalar(definableType) && (!author$project$Graphql$Generator$Scalar$isBuiltIn(name));
};
var author$project$Graphql$Generator$Scalar$fileContents = F2(
	function (apiSubmodule, typeDefinitions) {
		var typesToGenerate = A2(
			elm$core$List$map,
			function (_n0) {
				var name = _n0.a;
				var definableType = _n0.b;
				var description = _n0.c;
				return name;
			},
			A2(elm$core$List$filter, author$project$Graphql$Generator$Scalar$include, typeDefinitions));
		var moduleName = A2(
			elm$core$String$join,
			'.',
			_Utils_ap(
				apiSubmodule,
				_List_fromArray(
					['Scalar'])));
		return _Utils_eq(typesToGenerate, _List_Nil) ? A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    ""\n',
			_List_fromArray(
				[moduleName])) : A2(
			lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
			'module {0} exposing (..)\n\n\n{1}\n',
			_List_fromArray(
				[
					moduleName,
					A2(
					elm$core$String$join,
					'\n\n\n',
					A2(elm$core$List$map, author$project$Graphql$Generator$Scalar$generateType, typesToGenerate))
				]));
	});
var author$project$Graphql$Generator$Scalar$generate = F2(
	function (apiSubmodule, typeDefs) {
		return _Utils_Tuple2(
			_Utils_ap(
				apiSubmodule,
				_List_fromArray(
					['Scalar'])),
			A2(author$project$Graphql$Generator$Scalar$fileContents, apiSubmodule, typeDefs));
	});
var author$project$Graphql$Generator$TypeLockDefinitions$generateType = function (name) {
	return A2(
		lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
		'type {0}\n    = {0}',
		_List_fromArray(
			[
				author$project$Graphql$Parser$ClassCaseName$normalized(name)
			]));
};
var author$project$Graphql$Generator$TypeLockDefinitions$generateCommon = F4(
	function (typeName, includeName, apiSubmodule, typeDefinitions) {
		return function (fileContents) {
			return _Utils_Tuple2(
				_Utils_ap(
					apiSubmodule,
					_List_fromArray(
						[typeName])),
				fileContents);
		}(
			function () {
				var typesToGenerate = A2(
					elm$core$List$map,
					function (_n0) {
						var name = _n0.a;
						var definableType = _n0.b;
						var description = _n0.c;
						return name;
					},
					A2(elm$core$List$filter, includeName, typeDefinitions));
				return _Utils_eq(typesToGenerate, _List_Nil) ? A2(
					lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
					'module {0} exposing (..)\n\n\nplaceholder : String\nplaceholder =\n    ""\n',
					_List_fromArray(
						[
							A2(
							elm$core$String$join,
							'.',
							_Utils_ap(
								apiSubmodule,
								_List_fromArray(
									[typeName])))
						])) : A2(
					lukewestby$elm_string_interpolate$String$Interpolate$interpolate,
					'module {0} exposing (..)\n\n\n{1}\n',
					_List_fromArray(
						[
							A2(
							elm$core$String$join,
							'.',
							_Utils_ap(
								apiSubmodule,
								_List_fromArray(
									[typeName]))),
							A2(
							elm$core$String$join,
							'\n\n\n',
							A2(elm$core$List$map, author$project$Graphql$Generator$TypeLockDefinitions$generateType, typesToGenerate))
						]));
			}());
	});
var author$project$Graphql$Generator$TypeLockDefinitions$interfaceName = function (_n0) {
	var name = _n0.a;
	var definableType = _n0.b;
	var description = _n0.c;
	if (definableType.$ === 'InterfaceType') {
		return true;
	} else {
		return false;
	}
};
var author$project$Graphql$Generator$TypeLockDefinitions$objectName = function (_n0) {
	var name = _n0.a;
	var definableType = _n0.b;
	var description = _n0.c;
	if (definableType.$ === 'ObjectType') {
		return true;
	} else {
		return false;
	}
};
var author$project$Graphql$Generator$TypeLockDefinitions$unionName = function (_n0) {
	var name = _n0.a;
	var definableType = _n0.b;
	var description = _n0.c;
	if (definableType.$ === 'UnionType') {
		return true;
	} else {
		return false;
	}
};
var author$project$Graphql$Generator$TypeLockDefinitions$generate = F2(
	function (apiSubmodule, typeDefs) {
		return _List_fromArray(
			[
				A4(author$project$Graphql$Generator$TypeLockDefinitions$generateCommon, 'Union', author$project$Graphql$Generator$TypeLockDefinitions$unionName, apiSubmodule, typeDefs),
				A4(author$project$Graphql$Generator$TypeLockDefinitions$generateCommon, 'Object', author$project$Graphql$Generator$TypeLockDefinitions$objectName, apiSubmodule, typeDefs),
				A4(author$project$Graphql$Generator$TypeLockDefinitions$generateCommon, 'Interface', author$project$Graphql$Generator$TypeLockDefinitions$interfaceName, apiSubmodule, typeDefs)
			]);
	});
var elm$core$Tuple$mapFirst = F2(
	function (func, _n0) {
		var x = _n0.a;
		var y = _n0.b;
		return _Utils_Tuple2(
			func(x),
			y);
	});
var author$project$Graphql$Generator$Group$generateFiles = F2(
	function (apiSubmodule, _n0) {
		var typeDefinitions = _n0.typeDefinitions;
		var queryObjectName = _n0.queryObjectName;
		var mutationObjectName = _n0.mutationObjectName;
		var subscriptionObjectName = _n0.subscriptionObjectName;
		var context = {
			apiSubmodule: apiSubmodule,
			interfaces: author$project$Graphql$Generator$Group$interfacePossibleTypesDict(typeDefinitions),
			mutation: A2(elm$core$Maybe$map, author$project$Graphql$Parser$ClassCaseName$build, mutationObjectName),
			query: author$project$Graphql$Parser$ClassCaseName$build(queryObjectName),
			subscription: A2(elm$core$Maybe$map, author$project$Graphql$Parser$ClassCaseName$build, subscriptionObjectName)
		};
		var scalarDefinitions = A2(
			author$project$Graphql$Generator$Scalar$generate,
			apiSubmodule,
			A2(
				author$project$Graphql$Generator$Group$excludeSubscription,
				context,
				A2(
					author$project$Graphql$Generator$Group$excludeMutation,
					context,
					A2(
						author$project$Graphql$Generator$Group$excludeQuery,
						context,
						author$project$Graphql$Generator$Group$excludeBuiltIns(typeDefinitions)))));
		var typeLockDefinitions = A2(
			author$project$Graphql$Generator$TypeLockDefinitions$generate,
			apiSubmodule,
			A2(
				author$project$Graphql$Generator$Group$excludeSubscription,
				context,
				A2(
					author$project$Graphql$Generator$Group$excludeMutation,
					context,
					A2(
						author$project$Graphql$Generator$Group$excludeQuery,
						context,
						author$project$Graphql$Generator$Group$excludeBuiltIns(typeDefinitions)))));
		return elm$core$Dict$fromList(
			A2(
				elm$core$List$map,
				elm$core$Tuple$mapFirst(author$project$Graphql$Generator$Group$moduleToFileName),
				A2(
					elm$core$List$append,
					_List_fromArray(
						[scalarDefinitions]),
					A2(
						elm$core$List$append,
						_List_fromArray(
							[
								A2(author$project$Graphql$Generator$InputObjectFile$generate, context, typeDefinitions)
							]),
						A2(
							elm$core$List$append,
							typeLockDefinitions,
							A2(
								elm$core$List$filterMap,
								author$project$Graphql$Generator$Group$toPair(context),
								author$project$Graphql$Generator$Group$excludeBuiltIns(typeDefinitions)))))));
	});
var author$project$Graphql$Generator$Group$typeDefName = function (_n0) {
	var name = _n0.a;
	var definableType = _n0.b;
	var description = _n0.c;
	return author$project$Graphql$Parser$ClassCaseName$normalized(name);
};
var elm$core$List$sortBy = _List_sortBy;
var author$project$Graphql$Generator$Group$sortedIntrospectionData = F4(
	function (typeDefinitions, queryObjectName, mutationObjectName, subscriptionObjectName) {
		return {
			mutationObjectName: mutationObjectName,
			queryObjectName: queryObjectName,
			subscriptionObjectName: subscriptionObjectName,
			typeDefinitions: A2(elm$core$List$sortBy, author$project$Graphql$Generator$Group$typeDefName, typeDefinitions)
		};
	});
var author$project$Graphql$Parser$Type$EnumType = function (a) {
	return {$: 'EnumType', a: a};
};
var author$project$Graphql$Parser$Type$TypeDefinition = F3(
	function (a, b, c) {
		return {$: 'TypeDefinition', a: a, b: b, c: c};
	});
var author$project$Graphql$Parser$Type$typeDefinition = F3(
	function (name, definableType, description) {
		return A3(
			author$project$Graphql$Parser$Type$TypeDefinition,
			author$project$Graphql$Parser$ClassCaseName$build(name),
			definableType,
			description);
	});
var author$project$Graphql$Parser$Type$createEnum = F3(
	function (enumName, description, enumValues) {
		return A3(
			author$project$Graphql$Parser$Type$typeDefinition,
			enumName,
			author$project$Graphql$Parser$Type$EnumType(enumValues),
			description);
	});
var author$project$Graphql$Parser$Type$EnumValue = F2(
	function (name, description) {
		return {description: description, name: name};
	});
var elm$core$Basics$idiv = _Basics_idiv;
var elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = elm$core$Array$Leaf(
					A3(elm$core$Elm$JsArray$initialize, elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2(elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var elm$core$Basics$le = _Utils_le;
var elm$core$Basics$remainderBy = _Basics_remainderBy;
var elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return elm$core$Array$empty;
		} else {
			var tailLen = len % elm$core$Array$branchFactor;
			var tail = A3(elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - elm$core$Array$branchFactor;
			return A5(elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var elm$json$Json$Decode$field = _Json_decodeField;
var elm$json$Json$Decode$map = _Json_map1;
var elm$json$Json$Decode$map2 = _Json_map2;
var elm$json$Json$Decode$oneOf = _Json_oneOf;
var elm$json$Json$Decode$succeed = _Json_succeed;
var elm$json$Json$Decode$maybe = function (decoder) {
	return elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				A2(elm$json$Json$Decode$map, elm$core$Maybe$Just, decoder),
				elm$json$Json$Decode$succeed(elm$core$Maybe$Nothing)
			]));
};
var elm$json$Json$Decode$string = _Json_decodeString;
var author$project$Graphql$Parser$Type$enumValueDecoder = A3(
	elm$json$Json$Decode$map2,
	author$project$Graphql$Parser$Type$EnumValue,
	A2(
		elm$json$Json$Decode$map,
		author$project$Graphql$Parser$ClassCaseName$build,
		A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string)),
	A2(
		elm$json$Json$Decode$field,
		'description',
		elm$json$Json$Decode$maybe(elm$json$Json$Decode$string)));
var elm$json$Json$Decode$list = _Json_decodeList;
var elm$json$Json$Decode$map3 = _Json_map3;
var author$project$Graphql$Parser$Type$enumDecoder = A4(
	elm$json$Json$Decode$map3,
	author$project$Graphql$Parser$Type$createEnum,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	elm$json$Json$Decode$maybe(
		A2(elm$json$Json$Decode$field, 'description', elm$json$Json$Decode$string)),
	A2(
		elm$json$Json$Decode$field,
		'enumValues',
		elm$json$Json$Decode$list(author$project$Graphql$Parser$Type$enumValueDecoder)));
var author$project$Graphql$Parser$Type$InputObjectType = function (a) {
	return {$: 'InputObjectType', a: a};
};
var author$project$Graphql$Parser$Type$createInputObject = F2(
	function (inputObjectName, fields) {
		return A3(
			author$project$Graphql$Parser$Type$typeDefinition,
			inputObjectName,
			author$project$Graphql$Parser$Type$InputObjectType(fields),
			elm$core$Maybe$Nothing);
	});
var author$project$Graphql$Parser$Type$RawField = F4(
	function (name, description, ofType, args) {
		return {args: args, description: description, name: name, ofType: ofType};
	});
var author$project$Graphql$Parser$Type$RawTypeRef = function (a) {
	return {$: 'RawTypeRef', a: a};
};
var author$project$Graphql$Parser$Type$createRawTypeRef = F3(
	function (stringMaybe, typeKind, rawTypeRefMaybe) {
		return author$project$Graphql$Parser$Type$RawTypeRef(
			{kind: typeKind, name: stringMaybe, ofType: rawTypeRefMaybe});
	});
var author$project$Graphql$Parser$TypeKind$Enum = {$: 'Enum'};
var author$project$Graphql$Parser$TypeKind$InputObject = {$: 'InputObject'};
var author$project$Graphql$Parser$TypeKind$Interface = {$: 'Interface'};
var author$project$Graphql$Parser$TypeKind$List = {$: 'List'};
var author$project$Graphql$Parser$TypeKind$NonNull = {$: 'NonNull'};
var author$project$Graphql$Parser$TypeKind$Object = {$: 'Object'};
var author$project$Graphql$Parser$TypeKind$Scalar = {$: 'Scalar'};
var author$project$Graphql$Parser$TypeKind$Union = {$: 'Union'};
var elm$json$Json$Decode$andThen = _Json_andThen;
var elm$json$Json$Decode$fail = _Json_fail;
var author$project$Graphql$Parser$TypeKind$decoder = A2(
	elm$json$Json$Decode$andThen,
	function (string) {
		switch (string) {
			case 'SCALAR':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$Scalar);
			case 'OBJECT':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$Object);
			case 'LIST':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$List);
			case 'NON_NULL':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$NonNull);
			case 'ENUM':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$Enum);
			case 'INTERFACE':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$Interface);
			case 'INPUT_OBJECT':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$InputObject);
			case 'UNION':
				return elm$json$Json$Decode$succeed(author$project$Graphql$Parser$TypeKind$Union);
			default:
				return elm$json$Json$Decode$fail('Invalid TypeKind' + string);
		}
	},
	elm$json$Json$Decode$string);
var elm$json$Json$Decode$lazy = function (thunk) {
	return A2(
		elm$json$Json$Decode$andThen,
		thunk,
		elm$json$Json$Decode$succeed(_Utils_Tuple0));
};
function author$project$Graphql$Parser$Type$cyclic$typeRefDecoder() {
	return A4(
		elm$json$Json$Decode$map3,
		author$project$Graphql$Parser$Type$createRawTypeRef,
		elm$json$Json$Decode$maybe(
			A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string)),
		A2(elm$json$Json$Decode$field, 'kind', author$project$Graphql$Parser$TypeKind$decoder),
		elm$json$Json$Decode$maybe(
			A2(
				elm$json$Json$Decode$field,
				'ofType',
				elm$json$Json$Decode$lazy(
					function (_n0) {
						return author$project$Graphql$Parser$Type$cyclic$typeRefDecoder();
					}))));
}
try {
	var author$project$Graphql$Parser$Type$typeRefDecoder = author$project$Graphql$Parser$Type$cyclic$typeRefDecoder();
	author$project$Graphql$Parser$Type$cyclic$typeRefDecoder = function () {
		return author$project$Graphql$Parser$Type$typeRefDecoder;
	};
} catch ($) {
throw 'Some top-level definitions from `Graphql.Parser.Type` are causing infinite recursion:\n\n  ┌─────┐\n  │    typeRefDecoder\n  └─────┘\n\nThese errors are very tricky, so read https://elm-lang.org/0.19.0/halting-problem to learn how to fix it!';}
var elm$json$Json$Decode$map4 = _Json_map4;
var author$project$Graphql$Parser$Type$inputField = A5(
	elm$json$Json$Decode$map4,
	author$project$Graphql$Parser$Type$RawField,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	A2(
		elm$json$Json$Decode$field,
		'description',
		elm$json$Json$Decode$maybe(elm$json$Json$Decode$string)),
	A2(elm$json$Json$Decode$field, 'type', author$project$Graphql$Parser$Type$typeRefDecoder),
	elm$json$Json$Decode$succeed(_List_Nil));
var author$project$Graphql$Parser$CamelCaseName$CamelCaseName = function (a) {
	return {$: 'CamelCaseName', a: a};
};
var author$project$Graphql$Parser$CamelCaseName$build = author$project$Graphql$Parser$CamelCaseName$CamelCaseName;
var author$project$Graphql$Parser$Scalar$Boolean = {$: 'Boolean'};
var author$project$Graphql$Parser$Scalar$Custom = function (a) {
	return {$: 'Custom', a: a};
};
var author$project$Graphql$Parser$Scalar$Float = {$: 'Float'};
var author$project$Graphql$Parser$Scalar$Int = {$: 'Int'};
var author$project$Graphql$Parser$Scalar$String = {$: 'String'};
var author$project$Graphql$Parser$Scalar$parse = function (scalarName) {
	switch (scalarName) {
		case 'String':
			return author$project$Graphql$Parser$Scalar$String;
		case 'Boolean':
			return author$project$Graphql$Parser$Scalar$Boolean;
		case 'Int':
			return author$project$Graphql$Parser$Scalar$Int;
		case 'Float':
			return author$project$Graphql$Parser$Scalar$Float;
		default:
			return author$project$Graphql$Parser$Scalar$Custom(
				author$project$Graphql$Parser$ClassCaseName$build(scalarName));
	}
};
var author$project$Graphql$Parser$Type$EnumRef = function (a) {
	return {$: 'EnumRef', a: a};
};
var author$project$Graphql$Parser$Type$InputObjectRef = function (a) {
	return {$: 'InputObjectRef', a: a};
};
var author$project$Graphql$Parser$Type$InterfaceRef = function (a) {
	return {$: 'InterfaceRef', a: a};
};
var author$project$Graphql$Parser$Type$List = function (a) {
	return {$: 'List', a: a};
};
var author$project$Graphql$Parser$Type$ObjectRef = function (a) {
	return {$: 'ObjectRef', a: a};
};
var author$project$Graphql$Parser$Type$Scalar = function (a) {
	return {$: 'Scalar', a: a};
};
var author$project$Graphql$Parser$Type$UnionRef = function (a) {
	return {$: 'UnionRef', a: a};
};
var author$project$Graphql$Parser$Type$expectString = function (maybeString) {
	if (maybeString.$ === 'Just') {
		var string = maybeString.a;
		return string;
	} else {
		return _Debug_todo(
			'Graphql.Parser.Type',
			{
				start: {line: 269, column: 13},
				end: {line: 269, column: 23}
			})('Expected string but got Nothing');
	}
};
var author$project$Graphql$Parser$Type$ignoreRef = A2(
	author$project$Graphql$Parser$Type$TypeReference,
	author$project$Graphql$Parser$Type$Scalar(author$project$Graphql$Parser$Scalar$String),
	author$project$Graphql$Parser$Type$Nullable);
var author$project$Graphql$Parser$Type$parseRef = function (_n0) {
	var rawTypeRef = _n0.a;
	var _n1 = rawTypeRef.kind;
	switch (_n1.$) {
		case 'List':
			var _n2 = rawTypeRef.ofType;
			if (_n2.$ === 'Just') {
				var nestedOfType = _n2.a;
				return A2(
					author$project$Graphql$Parser$Type$TypeReference,
					author$project$Graphql$Parser$Type$List(
						author$project$Graphql$Parser$Type$parseRef(nestedOfType)),
					author$project$Graphql$Parser$Type$Nullable);
			} else {
				return _Debug_todo(
					'Graphql.Parser.Type',
					{
						start: {line: 281, column: 21},
						end: {line: 281, column: 31}
					})('Missing nested type for List reference');
			}
		case 'Scalar':
			var _n3 = rawTypeRef.name;
			if (_n3.$ === 'Just') {
				var scalarName = _n3.a;
				return A2(
					author$project$Graphql$Parser$Type$TypeReference,
					author$project$Graphql$Parser$Type$Scalar(
						author$project$Graphql$Parser$Scalar$parse(scalarName)),
					author$project$Graphql$Parser$Type$Nullable);
			} else {
				return _Debug_todo(
					'Graphql.Parser.Type',
					{
						start: {line: 291, column: 21},
						end: {line: 291, column: 31}
					})('Should not get null names for scalar references');
			}
		case 'Interface':
			var _n4 = rawTypeRef.name;
			if (_n4.$ === 'Just') {
				var interfaceName = _n4.a;
				return A2(
					author$project$Graphql$Parser$Type$TypeReference,
					author$project$Graphql$Parser$Type$InterfaceRef(interfaceName),
					author$project$Graphql$Parser$Type$Nullable);
			} else {
				return _Debug_todo(
					'Graphql.Parser.Type',
					{
						start: {line: 299, column: 21},
						end: {line: 299, column: 31}
					})('Should not get null names for interface references');
			}
		case 'Object':
			var _n5 = rawTypeRef.name;
			if (_n5.$ === 'Just') {
				var objectName = _n5.a;
				return A2(
					author$project$Graphql$Parser$Type$TypeReference,
					author$project$Graphql$Parser$Type$ObjectRef(objectName),
					author$project$Graphql$Parser$Type$Nullable);
			} else {
				return _Debug_todo(
					'Graphql.Parser.Type',
					{
						start: {line: 307, column: 21},
						end: {line: 307, column: 31}
					})('Should not get null names for object references');
			}
		case 'NonNull':
			var _n6 = rawTypeRef.ofType;
			if (_n6.$ === 'Just') {
				var actualOfType = _n6.a.a;
				var _n7 = _Utils_Tuple2(actualOfType.kind, actualOfType.name);
				switch (_n7.a.$) {
					case 'Scalar':
						var _n8 = _n7.a;
						var scalarName = _n7.b;
						return A2(
							author$project$Graphql$Parser$Type$TypeReference,
							author$project$Graphql$Parser$Type$Scalar(
								author$project$Graphql$Parser$Scalar$parse(
									author$project$Graphql$Parser$Type$expectString(scalarName))),
							author$project$Graphql$Parser$Type$NonNullable);
					case 'Object':
						var _n9 = _n7.a;
						var objectName = _n7.b;
						return A2(
							author$project$Graphql$Parser$Type$TypeReference,
							author$project$Graphql$Parser$Type$ObjectRef(
								author$project$Graphql$Parser$Type$expectString(objectName)),
							author$project$Graphql$Parser$Type$NonNullable);
					case 'Interface':
						var _n10 = _n7.a;
						var interfaceName = _n7.b;
						return A2(
							author$project$Graphql$Parser$Type$TypeReference,
							author$project$Graphql$Parser$Type$InterfaceRef(
								author$project$Graphql$Parser$Type$expectString(interfaceName)),
							author$project$Graphql$Parser$Type$NonNullable);
					case 'List':
						var _n11 = _n7.a;
						var _n12 = actualOfType.ofType;
						if (_n12.$ === 'Just') {
							var nestedOfType = _n12.a;
							return A2(
								author$project$Graphql$Parser$Type$TypeReference,
								author$project$Graphql$Parser$Type$List(
									author$project$Graphql$Parser$Type$parseRef(nestedOfType)),
								author$project$Graphql$Parser$Type$NonNullable);
						} else {
							return _Debug_todo(
								'Graphql.Parser.Type',
								{
									start: {line: 330, column: 37},
									end: {line: 330, column: 47}
								})('');
						}
					case 'NonNull':
						var _n13 = _n7.a;
						return _Debug_todo(
							'Graphql.Parser.Type',
							{
								start: {line: 333, column: 29},
								end: {line: 333, column: 39}
							})('Can\'t have nested non-null types');
					case 'Ignore':
						var _n14 = _n7.a;
						return author$project$Graphql$Parser$Type$ignoreRef;
					case 'Enum':
						var _n15 = _n7.a;
						var enumName = _n7.b;
						return A2(
							author$project$Graphql$Parser$Type$TypeReference,
							author$project$Graphql$Parser$Type$EnumRef(
								author$project$Graphql$Parser$ClassCaseName$build(
									author$project$Graphql$Parser$Type$expectString(enumName))),
							author$project$Graphql$Parser$Type$NonNullable);
					case 'InputObject':
						var _n16 = _n7.a;
						var inputObjectName = _n7.b;
						return A2(
							author$project$Graphql$Parser$Type$TypeReference,
							author$project$Graphql$Parser$Type$InputObjectRef(
								author$project$Graphql$Parser$ClassCaseName$build(
									author$project$Graphql$Parser$Type$expectString(inputObjectName))),
							author$project$Graphql$Parser$Type$NonNullable);
					default:
						var _n17 = _n7.a;
						return A2(
							author$project$Graphql$Parser$Type$TypeReference,
							author$project$Graphql$Parser$Type$UnionRef(
								author$project$Graphql$Parser$Type$expectString(actualOfType.name)),
							author$project$Graphql$Parser$Type$NonNullable);
				}
			} else {
				return author$project$Graphql$Parser$Type$ignoreRef;
			}
		case 'Ignore':
			return author$project$Graphql$Parser$Type$ignoreRef;
		case 'Enum':
			var _n18 = rawTypeRef.name;
			if (_n18.$ === 'Just') {
				var objectName = _n18.a;
				return A2(
					author$project$Graphql$Parser$Type$TypeReference,
					author$project$Graphql$Parser$Type$EnumRef(
						author$project$Graphql$Parser$ClassCaseName$build(objectName)),
					author$project$Graphql$Parser$Type$Nullable);
			} else {
				return _Debug_todo(
					'Graphql.Parser.Type',
					{
						start: {line: 359, column: 21},
						end: {line: 359, column: 31}
					})('Should not get null names for enum references');
			}
		case 'InputObject':
			var _n19 = rawTypeRef.name;
			if (_n19.$ === 'Just') {
				var inputObjectName = _n19.a;
				return A2(
					author$project$Graphql$Parser$Type$TypeReference,
					author$project$Graphql$Parser$Type$InputObjectRef(
						author$project$Graphql$Parser$ClassCaseName$build(inputObjectName)),
					author$project$Graphql$Parser$Type$Nullable);
			} else {
				return _Debug_todo(
					'Graphql.Parser.Type',
					{
						start: {line: 367, column: 21},
						end: {line: 367, column: 31}
					})('Should not get null names for input object references');
			}
		default:
			return A2(
				author$project$Graphql$Parser$Type$TypeReference,
				author$project$Graphql$Parser$Type$UnionRef(
					author$project$Graphql$Parser$Type$expectString(rawTypeRef.name)),
				author$project$Graphql$Parser$Type$Nullable);
	}
};
var author$project$Graphql$Parser$Type$parseField = function (_n0) {
	var name = _n0.name;
	var ofType = _n0.ofType;
	var args = _n0.args;
	var description = _n0.description;
	return {
		args: A2(
			elm$core$List$map,
			function (arg) {
				return {
					description: arg.description,
					name: author$project$Graphql$Parser$CamelCaseName$build(arg.name),
					typeRef: author$project$Graphql$Parser$Type$parseRef(arg.ofType)
				};
			},
			args),
		description: description,
		name: author$project$Graphql$Parser$CamelCaseName$build(name),
		typeRef: author$project$Graphql$Parser$Type$parseRef(ofType)
	};
};
var author$project$Graphql$Parser$Type$inputObjectDecoder = A3(
	elm$json$Json$Decode$map2,
	author$project$Graphql$Parser$Type$createInputObject,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	A2(
		elm$json$Json$Decode$field,
		'inputFields',
		elm$json$Json$Decode$list(
			A2(elm$json$Json$Decode$map, author$project$Graphql$Parser$Type$parseField, author$project$Graphql$Parser$Type$inputField))));
var author$project$Graphql$Parser$Type$InterfaceType = F2(
	function (a, b) {
		return {$: 'InterfaceType', a: a, b: b};
	});
var author$project$Graphql$Parser$Type$createInterface = F3(
	function (interfaceName, fields, possibleTypes) {
		return A3(
			author$project$Graphql$Parser$Type$typeDefinition,
			interfaceName,
			A2(
				author$project$Graphql$Parser$Type$InterfaceType,
				fields,
				A2(elm$core$List$map, author$project$Graphql$Parser$ClassCaseName$build, possibleTypes)),
			elm$core$Maybe$Nothing);
	});
var author$project$Graphql$Parser$Type$RawArg = F3(
	function (name, description, ofType) {
		return {description: description, name: name, ofType: ofType};
	});
var author$project$Graphql$Parser$Type$argDecoder = A4(
	elm$json$Json$Decode$map3,
	author$project$Graphql$Parser$Type$RawArg,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	A2(
		elm$json$Json$Decode$field,
		'description',
		elm$json$Json$Decode$maybe(elm$json$Json$Decode$string)),
	A2(elm$json$Json$Decode$field, 'type', author$project$Graphql$Parser$Type$typeRefDecoder));
var author$project$Graphql$Parser$Type$fieldDecoder = A5(
	elm$json$Json$Decode$map4,
	author$project$Graphql$Parser$Type$RawField,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	A2(
		elm$json$Json$Decode$field,
		'description',
		elm$json$Json$Decode$maybe(elm$json$Json$Decode$string)),
	A2(elm$json$Json$Decode$field, 'type', author$project$Graphql$Parser$Type$typeRefDecoder),
	A2(
		elm$json$Json$Decode$field,
		'args',
		elm$json$Json$Decode$list(author$project$Graphql$Parser$Type$argDecoder)));
var author$project$Graphql$Parser$Type$interfaceDecoder = A4(
	elm$json$Json$Decode$map3,
	author$project$Graphql$Parser$Type$createInterface,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	A2(
		elm$json$Json$Decode$field,
		'fields',
		elm$json$Json$Decode$list(
			A2(elm$json$Json$Decode$map, author$project$Graphql$Parser$Type$parseField, author$project$Graphql$Parser$Type$fieldDecoder))),
	A2(
		elm$json$Json$Decode$field,
		'possibleTypes',
		elm$json$Json$Decode$list(
			A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string))));
var author$project$Graphql$Parser$Type$ObjectType = function (a) {
	return {$: 'ObjectType', a: a};
};
var author$project$Graphql$Parser$Type$createObject = F2(
	function (objectName, fields) {
		return A3(
			author$project$Graphql$Parser$Type$typeDefinition,
			objectName,
			author$project$Graphql$Parser$Type$ObjectType(fields),
			elm$core$Maybe$Nothing);
	});
var author$project$Graphql$Parser$Type$objectDecoder = A3(
	elm$json$Json$Decode$map2,
	author$project$Graphql$Parser$Type$createObject,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	A2(
		elm$json$Json$Decode$field,
		'fields',
		elm$json$Json$Decode$list(
			A2(elm$json$Json$Decode$map, author$project$Graphql$Parser$Type$parseField, author$project$Graphql$Parser$Type$fieldDecoder))));
var author$project$Graphql$Parser$Type$ScalarType = {$: 'ScalarType'};
var author$project$Graphql$Parser$Type$scalarDecoder = A2(
	elm$json$Json$Decode$map,
	function (scalarName) {
		return A3(author$project$Graphql$Parser$Type$typeDefinition, scalarName, author$project$Graphql$Parser$Type$ScalarType, elm$core$Maybe$Nothing);
	},
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string));
var author$project$Graphql$Parser$Type$UnionType = function (a) {
	return {$: 'UnionType', a: a};
};
var author$project$Graphql$Parser$Type$createUnion = F2(
	function (interfaceName, possibleTypes) {
		return A3(
			author$project$Graphql$Parser$Type$typeDefinition,
			interfaceName,
			author$project$Graphql$Parser$Type$UnionType(
				A2(elm$core$List$map, author$project$Graphql$Parser$ClassCaseName$build, possibleTypes)),
			elm$core$Maybe$Nothing);
	});
var author$project$Graphql$Parser$Type$unionDecoder = A3(
	elm$json$Json$Decode$map2,
	author$project$Graphql$Parser$Type$createUnion,
	A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string),
	A2(
		elm$json$Json$Decode$field,
		'possibleTypes',
		elm$json$Json$Decode$list(
			A2(elm$json$Json$Decode$field, 'name', elm$json$Json$Decode$string))));
var author$project$Graphql$Parser$Type$decodeKind = function (kind) {
	switch (kind) {
		case 'OBJECT':
			return author$project$Graphql$Parser$Type$objectDecoder;
		case 'ENUM':
			return author$project$Graphql$Parser$Type$enumDecoder;
		case 'SCALAR':
			return author$project$Graphql$Parser$Type$scalarDecoder;
		case 'INTERFACE':
			return author$project$Graphql$Parser$Type$interfaceDecoder;
		case 'UNION':
			return author$project$Graphql$Parser$Type$unionDecoder;
		case 'INPUT_OBJECT':
			return author$project$Graphql$Parser$Type$inputObjectDecoder;
		default:
			return elm$json$Json$Decode$fail('Unexpected kind ' + kind);
	}
};
var author$project$Graphql$Parser$Type$decoder = A2(
	elm$json$Json$Decode$andThen,
	author$project$Graphql$Parser$Type$decodeKind,
	A2(elm$json$Json$Decode$field, 'kind', elm$json$Json$Decode$string));
var elm$json$Json$Decode$at = F2(
	function (fields, decoder) {
		return A3(elm$core$List$foldr, elm$json$Json$Decode$field, decoder, fields);
	});
var author$project$Graphql$Parser$decoder = function (baseModule) {
	return A2(
		elm$json$Json$Decode$map,
		author$project$Graphql$Generator$Group$generateFiles(baseModule),
		A5(
			elm$json$Json$Decode$map4,
			author$project$Graphql$Generator$Group$sortedIntrospectionData,
			A2(
				elm$json$Json$Decode$at,
				_List_fromArray(
					['__schema', 'types']),
				elm$json$Json$Decode$list(author$project$Graphql$Parser$Type$decoder)),
			A2(
				elm$json$Json$Decode$at,
				_List_fromArray(
					['__schema', 'queryType', 'name']),
				elm$json$Json$Decode$string),
			elm$json$Json$Decode$maybe(
				A2(
					elm$json$Json$Decode$at,
					_List_fromArray(
						['__schema', 'mutationType', 'name']),
					elm$json$Json$Decode$string)),
			elm$json$Json$Decode$maybe(
				A2(
					elm$json$Json$Decode$at,
					_List_fromArray(
						['__schema', 'subscriptionType', 'name']),
					elm$json$Json$Decode$string))));
};
var author$project$Main$generatedFiles = _Platform_outgoingPort('generatedFiles', elm$core$Basics$identity);
var elm$core$Debug$toString = _Debug_toString;
var elm$json$Json$Decode$decodeValue = _Json_run;
var elm$json$Json$Encode$string = _Json_wrap;
var elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			elm$core$List$foldl,
			F2(
				function (_n0, obj) {
					var k = _n0.a;
					var v = _n0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(_Utils_Tuple0),
			pairs));
};
var elm_community$json_extra$Json$Encode$Extra$dict = F2(
	function (toKey, toValue) {
		return A2(
			elm$core$Basics$composeR,
			elm$core$Dict$toList,
			A2(
				elm$core$Basics$composeR,
				elm$core$List$map(
					function (_n0) {
						var key = _n0.a;
						var value = _n0.b;
						return _Utils_Tuple2(
							toKey(key),
							toValue(value));
					}),
				elm$json$Json$Encode$object));
	});
var author$project$Main$init = function (flags) {
	var _n0 = A2(
		elm$json$Json$Decode$decodeValue,
		author$project$Graphql$Parser$decoder(flags.baseModule),
		flags.data);
	if (_n0.$ === 'Ok') {
		var fields = _n0.a;
		return _Utils_Tuple2(
			_Utils_Tuple0,
			author$project$Main$generatedFiles(
				A3(elm_community$json_extra$Json$Encode$Extra$dict, elm$core$Basics$identity, elm$json$Json$Encode$string, fields)));
	} else {
		var error = _n0.a;
		return _Debug_todo(
			'Main',
			{
				start: {line: 40, column: 13},
				end: {line: 40, column: 23}
			})(
			'Got error ' + elm$core$Debug$toString(error));
	}
};
var elm$core$Platform$worker = _Platform_worker;
var elm$core$Platform$Cmd$batch = _Platform_batch;
var elm$core$Platform$Cmd$none = elm$core$Platform$Cmd$batch(_List_Nil);
var elm$core$Platform$Sub$batch = _Platform_batch;
var elm$core$Platform$Sub$none = elm$core$Platform$Sub$batch(_List_Nil);
var elm$json$Json$Decode$value = _Json_decodeValue;
var author$project$Main$main = elm$core$Platform$worker(
	{
		init: author$project$Main$init,
		subscriptions: function (_n0) {
			return elm$core$Platform$Sub$none;
		},
		update: F2(
			function (msg, model) {
				return _Utils_Tuple2(model, elm$core$Platform$Cmd$none);
			})
	});
_Platform_export({'Main':{'init':author$project$Main$main(
	A2(
		elm$json$Json$Decode$andThen,
		function (data) {
			return A2(
				elm$json$Json$Decode$andThen,
				function (baseModule) {
					return elm$json$Json$Decode$succeed(
						{baseModule: baseModule, data: data});
				},
				A2(
					elm$json$Json$Decode$field,
					'baseModule',
					elm$json$Json$Decode$list(elm$json$Json$Decode$string)));
		},
		A2(elm$json$Json$Decode$field, 'data', elm$json$Json$Decode$value)))(0)}});}(this));

/***/ }),
/* 31 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


// simple mutable assign
function assign () {
  const args = [].slice.call(arguments).filter(i => i)
  const dest = args.shift()
  args.forEach(src => {
    Object.keys(src).forEach(key => {
      dest[key] = src[key]
    })
  })

  return dest
}

module.exports = assign


/***/ }),
/* 32 */
/***/ (function(module, exports, __webpack_require__) {

var fs = __webpack_require__(15)
var constants = __webpack_require__(33)

var origCwd = process.cwd
var cwd = null

var platform = process.env.GRACEFUL_FS_PLATFORM || process.platform

process.cwd = function() {
  if (!cwd)
    cwd = origCwd.call(process)
  return cwd
}
try {
  process.cwd()
} catch (er) {}

var chdir = process.chdir
process.chdir = function(d) {
  cwd = null
  chdir.call(process, d)
}

module.exports = patch

function patch (fs) {
  // (re-)implement some things that are known busted or missing.

  // lchmod, broken prior to 0.6.2
  // back-port the fix here.
  if (constants.hasOwnProperty('O_SYMLINK') &&
      process.version.match(/^v0\.6\.[0-2]|^v0\.5\./)) {
    patchLchmod(fs)
  }

  // lutimes implementation, or no-op
  if (!fs.lutimes) {
    patchLutimes(fs)
  }

  // https://github.com/isaacs/node-graceful-fs/issues/4
  // Chown should not fail on einval or eperm if non-root.
  // It should not fail on enosys ever, as this just indicates
  // that a fs doesn't support the intended operation.

  fs.chown = chownFix(fs.chown)
  fs.fchown = chownFix(fs.fchown)
  fs.lchown = chownFix(fs.lchown)

  fs.chmod = chmodFix(fs.chmod)
  fs.fchmod = chmodFix(fs.fchmod)
  fs.lchmod = chmodFix(fs.lchmod)

  fs.chownSync = chownFixSync(fs.chownSync)
  fs.fchownSync = chownFixSync(fs.fchownSync)
  fs.lchownSync = chownFixSync(fs.lchownSync)

  fs.chmodSync = chmodFixSync(fs.chmodSync)
  fs.fchmodSync = chmodFixSync(fs.fchmodSync)
  fs.lchmodSync = chmodFixSync(fs.lchmodSync)

  fs.stat = statFix(fs.stat)
  fs.fstat = statFix(fs.fstat)
  fs.lstat = statFix(fs.lstat)

  fs.statSync = statFixSync(fs.statSync)
  fs.fstatSync = statFixSync(fs.fstatSync)
  fs.lstatSync = statFixSync(fs.lstatSync)

  // if lchmod/lchown do not exist, then make them no-ops
  if (!fs.lchmod) {
    fs.lchmod = function (path, mode, cb) {
      if (cb) process.nextTick(cb)
    }
    fs.lchmodSync = function () {}
  }
  if (!fs.lchown) {
    fs.lchown = function (path, uid, gid, cb) {
      if (cb) process.nextTick(cb)
    }
    fs.lchownSync = function () {}
  }

  // on Windows, A/V software can lock the directory, causing this
  // to fail with an EACCES or EPERM if the directory contains newly
  // created files.  Try again on failure, for up to 60 seconds.

  // Set the timeout this long because some Windows Anti-Virus, such as Parity
  // bit9, may lock files for up to a minute, causing npm package install
  // failures. Also, take care to yield the scheduler. Windows scheduling gives
  // CPU to a busy looping process, which can cause the program causing the lock
  // contention to be starved of CPU by node, so the contention doesn't resolve.
  if (platform === "win32") {
    fs.rename = (function (fs$rename) { return function (from, to, cb) {
      var start = Date.now()
      var backoff = 0;
      fs$rename(from, to, function CB (er) {
        if (er
            && (er.code === "EACCES" || er.code === "EPERM")
            && Date.now() - start < 60000) {
          setTimeout(function() {
            fs.stat(to, function (stater, st) {
              if (stater && stater.code === "ENOENT")
                fs$rename(from, to, CB);
              else
                cb(er)
            })
          }, backoff)
          if (backoff < 100)
            backoff += 10;
          return;
        }
        if (cb) cb(er)
      })
    }})(fs.rename)
  }

  // if read() returns EAGAIN, then just try it again.
  fs.read = (function (fs$read) { return function (fd, buffer, offset, length, position, callback_) {
    var callback
    if (callback_ && typeof callback_ === 'function') {
      var eagCounter = 0
      callback = function (er, _, __) {
        if (er && er.code === 'EAGAIN' && eagCounter < 10) {
          eagCounter ++
          return fs$read.call(fs, fd, buffer, offset, length, position, callback)
        }
        callback_.apply(this, arguments)
      }
    }
    return fs$read.call(fs, fd, buffer, offset, length, position, callback)
  }})(fs.read)

  fs.readSync = (function (fs$readSync) { return function (fd, buffer, offset, length, position) {
    var eagCounter = 0
    while (true) {
      try {
        return fs$readSync.call(fs, fd, buffer, offset, length, position)
      } catch (er) {
        if (er.code === 'EAGAIN' && eagCounter < 10) {
          eagCounter ++
          continue
        }
        throw er
      }
    }
  }})(fs.readSync)
}

function patchLchmod (fs) {
  fs.lchmod = function (path, mode, callback) {
    fs.open( path
           , constants.O_WRONLY | constants.O_SYMLINK
           , mode
           , function (err, fd) {
      if (err) {
        if (callback) callback(err)
        return
      }
      // prefer to return the chmod error, if one occurs,
      // but still try to close, and report closing errors if they occur.
      fs.fchmod(fd, mode, function (err) {
        fs.close(fd, function(err2) {
          if (callback) callback(err || err2)
        })
      })
    })
  }

  fs.lchmodSync = function (path, mode) {
    var fd = fs.openSync(path, constants.O_WRONLY | constants.O_SYMLINK, mode)

    // prefer to return the chmod error, if one occurs,
    // but still try to close, and report closing errors if they occur.
    var threw = true
    var ret
    try {
      ret = fs.fchmodSync(fd, mode)
      threw = false
    } finally {
      if (threw) {
        try {
          fs.closeSync(fd)
        } catch (er) {}
      } else {
        fs.closeSync(fd)
      }
    }
    return ret
  }
}

function patchLutimes (fs) {
  if (constants.hasOwnProperty("O_SYMLINK")) {
    fs.lutimes = function (path, at, mt, cb) {
      fs.open(path, constants.O_SYMLINK, function (er, fd) {
        if (er) {
          if (cb) cb(er)
          return
        }
        fs.futimes(fd, at, mt, function (er) {
          fs.close(fd, function (er2) {
            if (cb) cb(er || er2)
          })
        })
      })
    }

    fs.lutimesSync = function (path, at, mt) {
      var fd = fs.openSync(path, constants.O_SYMLINK)
      var ret
      var threw = true
      try {
        ret = fs.futimesSync(fd, at, mt)
        threw = false
      } finally {
        if (threw) {
          try {
            fs.closeSync(fd)
          } catch (er) {}
        } else {
          fs.closeSync(fd)
        }
      }
      return ret
    }

  } else {
    fs.lutimes = function (_a, _b, _c, cb) { if (cb) process.nextTick(cb) }
    fs.lutimesSync = function () {}
  }
}

function chmodFix (orig) {
  if (!orig) return orig
  return function (target, mode, cb) {
    return orig.call(fs, target, mode, function (er) {
      if (chownErOk(er)) er = null
      if (cb) cb.apply(this, arguments)
    })
  }
}

function chmodFixSync (orig) {
  if (!orig) return orig
  return function (target, mode) {
    try {
      return orig.call(fs, target, mode)
    } catch (er) {
      if (!chownErOk(er)) throw er
    }
  }
}


function chownFix (orig) {
  if (!orig) return orig
  return function (target, uid, gid, cb) {
    return orig.call(fs, target, uid, gid, function (er) {
      if (chownErOk(er)) er = null
      if (cb) cb.apply(this, arguments)
    })
  }
}

function chownFixSync (orig) {
  if (!orig) return orig
  return function (target, uid, gid) {
    try {
      return orig.call(fs, target, uid, gid)
    } catch (er) {
      if (!chownErOk(er)) throw er
    }
  }
}


function statFix (orig) {
  if (!orig) return orig
  // Older versions of Node erroneously returned signed integers for
  // uid + gid.
  return function (target, cb) {
    return orig.call(fs, target, function (er, stats) {
      if (!stats) return cb.apply(this, arguments)
      if (stats.uid < 0) stats.uid += 0x100000000
      if (stats.gid < 0) stats.gid += 0x100000000
      if (cb) cb.apply(this, arguments)
    })
  }
}

function statFixSync (orig) {
  if (!orig) return orig
  // Older versions of Node erroneously returned signed integers for
  // uid + gid.
  return function (target) {
    var stats = orig.call(fs, target)
    if (stats.uid < 0) stats.uid += 0x100000000
    if (stats.gid < 0) stats.gid += 0x100000000
    return stats;
  }
}

// ENOSYS means that the fs doesn't support the op. Just ignore
// that, because it doesn't matter.
//
// if there's no getuid, or if getuid() is something other
// than 0, and the error is EINVAL or EPERM, then just ignore
// it.
//
// This specific case is a silent failure in cp, install, tar,
// and most other unix tools that manage permissions.
//
// When running as root, or if other types of errors are
// encountered, then it's strict.
function chownErOk (er) {
  if (!er)
    return true

  if (er.code === "ENOSYS")
    return true

  var nonroot = !process.getuid || process.getuid() !== 0
  if (nonroot) {
    if (er.code === "EINVAL" || er.code === "EPERM")
      return true
  }

  return false
}


/***/ }),
/* 33 */
/***/ (function(module, exports) {

module.exports = require("constants");

/***/ }),
/* 34 */
/***/ (function(module, exports, __webpack_require__) {

var Stream = __webpack_require__(6).Stream

module.exports = legacy

function legacy (fs) {
  return {
    ReadStream: ReadStream,
    WriteStream: WriteStream
  }

  function ReadStream (path, options) {
    if (!(this instanceof ReadStream)) return new ReadStream(path, options);

    Stream.call(this);

    var self = this;

    this.path = path;
    this.fd = null;
    this.readable = true;
    this.paused = false;

    this.flags = 'r';
    this.mode = 438; /*=0666*/
    this.bufferSize = 64 * 1024;

    options = options || {};

    // Mixin options into this
    var keys = Object.keys(options);
    for (var index = 0, length = keys.length; index < length; index++) {
      var key = keys[index];
      this[key] = options[key];
    }

    if (this.encoding) this.setEncoding(this.encoding);

    if (this.start !== undefined) {
      if ('number' !== typeof this.start) {
        throw TypeError('start must be a Number');
      }
      if (this.end === undefined) {
        this.end = Infinity;
      } else if ('number' !== typeof this.end) {
        throw TypeError('end must be a Number');
      }

      if (this.start > this.end) {
        throw new Error('start must be <= end');
      }

      this.pos = this.start;
    }

    if (this.fd !== null) {
      process.nextTick(function() {
        self._read();
      });
      return;
    }

    fs.open(this.path, this.flags, this.mode, function (err, fd) {
      if (err) {
        self.emit('error', err);
        self.readable = false;
        return;
      }

      self.fd = fd;
      self.emit('open', fd);
      self._read();
    })
  }

  function WriteStream (path, options) {
    if (!(this instanceof WriteStream)) return new WriteStream(path, options);

    Stream.call(this);

    this.path = path;
    this.fd = null;
    this.writable = true;

    this.flags = 'w';
    this.encoding = 'binary';
    this.mode = 438; /*=0666*/
    this.bytesWritten = 0;

    options = options || {};

    // Mixin options into this
    var keys = Object.keys(options);
    for (var index = 0, length = keys.length; index < length; index++) {
      var key = keys[index];
      this[key] = options[key];
    }

    if (this.start !== undefined) {
      if ('number' !== typeof this.start) {
        throw TypeError('start must be a Number');
      }
      if (this.start < 0) {
        throw new Error('start must be >= zero');
      }

      this.pos = this.start;
    }

    this.busy = false;
    this._queue = [];

    if (this.fd === null) {
      this._open = fs.open;
      this._queue.push([this._open, this.path, this.flags, this.mode, undefined]);
      this.flush();
    }
  }
}


/***/ }),
/* 35 */
/***/ (function(module, exports, __webpack_require__) {

const u = __webpack_require__(2).fromCallback
module.exports = {
  copy: u(__webpack_require__(16))
}


/***/ }),
/* 36 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const invalidWin32Path = __webpack_require__(17).invalidWin32Path

const o777 = parseInt('0777', 8)

function mkdirs (p, opts, callback, made) {
  if (typeof opts === 'function') {
    callback = opts
    opts = {}
  } else if (!opts || typeof opts !== 'object') {
    opts = { mode: opts }
  }

  if (process.platform === 'win32' && invalidWin32Path(p)) {
    const errInval = new Error(p + ' contains invalid WIN32 path characters.')
    errInval.code = 'EINVAL'
    return callback(errInval)
  }

  let mode = opts.mode
  const xfs = opts.fs || fs

  if (mode === undefined) {
    mode = o777 & (~process.umask())
  }
  if (!made) made = null

  callback = callback || function () {}
  p = path.resolve(p)

  xfs.mkdir(p, mode, er => {
    if (!er) {
      made = made || p
      return callback(null, made)
    }
    switch (er.code) {
      case 'ENOENT':
        if (path.dirname(p) === p) return callback(er)
        mkdirs(path.dirname(p), opts, (er, made) => {
          if (er) callback(er, made)
          else mkdirs(p, opts, callback, made)
        })
        break

      // In the case of any other error, just see if there's a dir
      // there already.  If so, then hooray!  If not, then something
      // is borked.
      default:
        xfs.stat(p, (er2, stat) => {
          // if the stat fails, then that's super weird.
          // let the original error be the failure reason.
          if (er2 || !stat.isDirectory()) callback(er, made)
          else callback(null, made)
        })
        break
    }
  })
}

module.exports = mkdirs


/***/ }),
/* 37 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const invalidWin32Path = __webpack_require__(17).invalidWin32Path

const o777 = parseInt('0777', 8)

function mkdirsSync (p, opts, made) {
  if (!opts || typeof opts !== 'object') {
    opts = { mode: opts }
  }

  let mode = opts.mode
  const xfs = opts.fs || fs

  if (process.platform === 'win32' && invalidWin32Path(p)) {
    const errInval = new Error(p + ' contains invalid WIN32 path characters.')
    errInval.code = 'EINVAL'
    throw errInval
  }

  if (mode === undefined) {
    mode = o777 & (~process.umask())
  }
  if (!made) made = null

  p = path.resolve(p)

  try {
    xfs.mkdirSync(p, mode)
    made = made || p
  } catch (err0) {
    switch (err0.code) {
      case 'ENOENT':
        if (path.dirname(p) === p) throw err0
        made = mkdirsSync(path.dirname(p), opts, made)
        mkdirsSync(p, opts, made)
        break

      // In the case of any other error, just see if there's a dir
      // there already.  If so, then hooray!  If not, then something
      // is borked.
      default:
        let stat
        try {
          stat = xfs.statSync(p)
        } catch (err1) {
          throw err0
        }
        if (!stat.isDirectory()) throw err0
        break
    }
  }

  return made
}

module.exports = mkdirsSync


/***/ }),
/* 38 */
/***/ (function(module, exports) {

module.exports = require("os");

/***/ }),
/* 39 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const mkdirpSync = __webpack_require__(3).mkdirsSync
const utimesSync = __webpack_require__(18).utimesMillisSync

const notExist = Symbol('notExist')
const existsReg = Symbol('existsReg')

function copySync (src, dest, opts) {
  if (typeof opts === 'function') {
    opts = {filter: opts}
  }

  opts = opts || {}
  opts.clobber = 'clobber' in opts ? !!opts.clobber : true // default to true for now
  opts.overwrite = 'overwrite' in opts ? !!opts.overwrite : opts.clobber // overwrite falls back to clobber

  // Warn about using preserveTimestamps on 32-bit node
  if (opts.preserveTimestamps && process.arch === 'ia32') {
    console.warn(`fs-extra: Using the preserveTimestamps option in 32-bit node is not recommended;\n
    see https://github.com/jprichardson/node-fs-extra/issues/269`)
  }

  src = path.resolve(src)
  dest = path.resolve(dest)

  // don't allow src and dest to be the same
  if (src === dest) throw new Error('Source and destination must not be the same.')

  if (opts.filter && !opts.filter(src, dest)) return

  const destParent = path.dirname(dest)
  if (!fs.existsSync(destParent)) mkdirpSync(destParent)
  return startCopy(src, dest, opts)
}

function startCopy (src, dest, opts) {
  if (opts.filter && !opts.filter(src, dest)) return
  return getStats(src, dest, opts)
}

function getStats (src, dest, opts) {
  const statSync = opts.dereference ? fs.statSync : fs.lstatSync
  const st = statSync(src)

  if (st.isDirectory()) return onDir(st, src, dest, opts)
  else if (st.isFile() ||
           st.isCharacterDevice() ||
           st.isBlockDevice()) return onFile(st, src, dest, opts)
  else if (st.isSymbolicLink()) return onLink(src, dest, opts)
}

function onFile (srcStat, src, dest, opts) {
  const resolvedPath = checkDest(dest)
  if (resolvedPath === notExist) {
    return copyFile(srcStat, src, dest, opts)
  } else if (resolvedPath === existsReg) {
    return mayCopyFile(srcStat, src, dest, opts)
  } else {
    if (src === resolvedPath) return
    return mayCopyFile(srcStat, src, dest, opts)
  }
}

function mayCopyFile (srcStat, src, dest, opts) {
  if (opts.overwrite) {
    fs.unlinkSync(dest)
    return copyFile(srcStat, src, dest, opts)
  } else if (opts.errorOnExist) {
    throw new Error(`'${dest}' already exists`)
  }
}

function copyFile (srcStat, src, dest, opts) {
  if (typeof fs.copyFileSync === 'function') {
    fs.copyFileSync(src, dest)
    fs.chmodSync(dest, srcStat.mode)
    if (opts.preserveTimestamps) {
      return utimesSync(dest, srcStat.atime, srcStat.mtime)
    }
    return
  }
  return copyFileFallback(srcStat, src, dest, opts)
}

function copyFileFallback (srcStat, src, dest, opts) {
  const BUF_LENGTH = 64 * 1024
  const _buff = __webpack_require__(20)(BUF_LENGTH)

  const fdr = fs.openSync(src, 'r')
  const fdw = fs.openSync(dest, 'w', srcStat.mode)
  let bytesRead = 1
  let pos = 0

  while (bytesRead > 0) {
    bytesRead = fs.readSync(fdr, _buff, 0, BUF_LENGTH, pos)
    fs.writeSync(fdw, _buff, 0, bytesRead)
    pos += bytesRead
  }

  if (opts.preserveTimestamps) fs.futimesSync(fdw, srcStat.atime, srcStat.mtime)

  fs.closeSync(fdr)
  fs.closeSync(fdw)
}

function onDir (srcStat, src, dest, opts) {
  const resolvedPath = checkDest(dest)
  if (resolvedPath === notExist) {
    if (isSrcSubdir(src, dest)) {
      throw new Error(`Cannot copy '${src}' to a subdirectory of itself, '${dest}'.`)
    }
    return mkDirAndCopy(srcStat, src, dest, opts)
  } else if (resolvedPath === existsReg) {
    if (isSrcSubdir(src, dest)) {
      throw new Error(`Cannot copy '${src}' to a subdirectory of itself, '${dest}'.`)
    }
    return mayCopyDir(src, dest, opts)
  } else {
    if (src === resolvedPath) return
    return copyDir(src, dest, opts)
  }
}

function mayCopyDir (src, dest, opts) {
  if (!fs.statSync(dest).isDirectory()) {
    throw new Error(`Cannot overwrite non-directory '${dest}' with directory '${src}'.`)
  }
  return copyDir(src, dest, opts)
}

function mkDirAndCopy (srcStat, src, dest, opts) {
  fs.mkdirSync(dest, srcStat.mode)
  fs.chmodSync(dest, srcStat.mode)
  return copyDir(src, dest, opts)
}

function copyDir (src, dest, opts) {
  fs.readdirSync(src).forEach(item => {
    startCopy(path.join(src, item), path.join(dest, item), opts)
  })
}

function onLink (src, dest, opts) {
  let resolvedSrcPath = fs.readlinkSync(src)

  if (opts.dereference) {
    resolvedSrcPath = path.resolve(process.cwd(), resolvedSrcPath)
  }

  let resolvedDestPath = checkDest(dest)
  if (resolvedDestPath === notExist || resolvedDestPath === existsReg) {
    // if dest already exists, fs throws error anyway,
    // so no need to guard against it here.
    return fs.symlinkSync(resolvedSrcPath, dest)
  } else {
    if (opts.dereference) {
      resolvedDestPath = path.resolve(process.cwd(), resolvedDestPath)
    }
    if (resolvedDestPath === resolvedSrcPath) return

    // prevent copy if src is a subdir of dest since unlinking
    // dest in this case would result in removing src contents
    // and therefore a broken symlink would be created.
    if (fs.statSync(dest).isDirectory() && isSrcSubdir(resolvedDestPath, resolvedSrcPath)) {
      throw new Error(`Cannot overwrite '${resolvedDestPath}' with '${resolvedSrcPath}'.`)
    }
    return copyLink(resolvedSrcPath, dest)
  }
}

function copyLink (resolvedSrcPath, dest) {
  fs.unlinkSync(dest)
  return fs.symlinkSync(resolvedSrcPath, dest)
}

// check if dest exists and/or is a symlink
function checkDest (dest) {
  let resolvedPath
  try {
    resolvedPath = fs.readlinkSync(dest)
  } catch (err) {
    if (err.code === 'ENOENT') return notExist

    // dest exists and is a regular file or directory, Windows may throw UNKNOWN error
    if (err.code === 'EINVAL' || err.code === 'UNKNOWN') return existsReg

    throw err
  }
  return resolvedPath // dest exists and is a symlink
}

// return true if dest is a subdir of src, otherwise false.
// extract dest base dir and check if that is the same as src basename
function isSrcSubdir (src, dest) {
  const baseDir = dest.split(path.dirname(src) + path.sep)[1]
  if (baseDir) {
    const destBasename = baseDir.split(path.sep)[0]
    if (destBasename) {
      return src !== dest && dest.indexOf(src) > -1 && destBasename === path.basename(src)
    }
    return false
  }
  return false
}

module.exports = copySync


/***/ }),
/* 40 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const assert = __webpack_require__(8)

const isWindows = (process.platform === 'win32')

function defaults (options) {
  const methods = [
    'unlink',
    'chmod',
    'stat',
    'lstat',
    'rmdir',
    'readdir'
  ]
  methods.forEach(m => {
    options[m] = options[m] || fs[m]
    m = m + 'Sync'
    options[m] = options[m] || fs[m]
  })

  options.maxBusyTries = options.maxBusyTries || 3
}

function rimraf (p, options, cb) {
  let busyTries = 0

  if (typeof options === 'function') {
    cb = options
    options = {}
  }

  assert(p, 'rimraf: missing path')
  assert.equal(typeof p, 'string', 'rimraf: path should be a string')
  assert.equal(typeof cb, 'function', 'rimraf: callback function required')
  assert(options, 'rimraf: invalid options argument provided')
  assert.equal(typeof options, 'object', 'rimraf: options should be object')

  defaults(options)

  rimraf_(p, options, function CB (er) {
    if (er) {
      if ((er.code === 'EBUSY' || er.code === 'ENOTEMPTY' || er.code === 'EPERM') &&
          busyTries < options.maxBusyTries) {
        busyTries++
        let time = busyTries * 100
        // try again, with the same exact callback as this one.
        return setTimeout(() => rimraf_(p, options, CB), time)
      }

      // already gone
      if (er.code === 'ENOENT') er = null
    }

    cb(er)
  })
}

// Two possible strategies.
// 1. Assume it's a file.  unlink it, then do the dir stuff on EPERM or EISDIR
// 2. Assume it's a directory.  readdir, then do the file stuff on ENOTDIR
//
// Both result in an extra syscall when you guess wrong.  However, there
// are likely far more normal files in the world than directories.  This
// is based on the assumption that a the average number of files per
// directory is >= 1.
//
// If anyone ever complains about this, then I guess the strategy could
// be made configurable somehow.  But until then, YAGNI.
function rimraf_ (p, options, cb) {
  assert(p)
  assert(options)
  assert(typeof cb === 'function')

  // sunos lets the root user unlink directories, which is... weird.
  // so we have to lstat here and make sure it's not a dir.
  options.lstat(p, (er, st) => {
    if (er && er.code === 'ENOENT') {
      return cb(null)
    }

    // Windows can EPERM on stat.  Life is suffering.
    if (er && er.code === 'EPERM' && isWindows) {
      return fixWinEPERM(p, options, er, cb)
    }

    if (st && st.isDirectory()) {
      return rmdir(p, options, er, cb)
    }

    options.unlink(p, er => {
      if (er) {
        if (er.code === 'ENOENT') {
          return cb(null)
        }
        if (er.code === 'EPERM') {
          return (isWindows)
            ? fixWinEPERM(p, options, er, cb)
            : rmdir(p, options, er, cb)
        }
        if (er.code === 'EISDIR') {
          return rmdir(p, options, er, cb)
        }
      }
      return cb(er)
    })
  })
}

function fixWinEPERM (p, options, er, cb) {
  assert(p)
  assert(options)
  assert(typeof cb === 'function')
  if (er) {
    assert(er instanceof Error)
  }

  options.chmod(p, 0o666, er2 => {
    if (er2) {
      cb(er2.code === 'ENOENT' ? null : er)
    } else {
      options.stat(p, (er3, stats) => {
        if (er3) {
          cb(er3.code === 'ENOENT' ? null : er)
        } else if (stats.isDirectory()) {
          rmdir(p, options, er, cb)
        } else {
          options.unlink(p, cb)
        }
      })
    }
  })
}

function fixWinEPERMSync (p, options, er) {
  let stats

  assert(p)
  assert(options)
  if (er) {
    assert(er instanceof Error)
  }

  try {
    options.chmodSync(p, 0o666)
  } catch (er2) {
    if (er2.code === 'ENOENT') {
      return
    } else {
      throw er
    }
  }

  try {
    stats = options.statSync(p)
  } catch (er3) {
    if (er3.code === 'ENOENT') {
      return
    } else {
      throw er
    }
  }

  if (stats.isDirectory()) {
    rmdirSync(p, options, er)
  } else {
    options.unlinkSync(p)
  }
}

function rmdir (p, options, originalEr, cb) {
  assert(p)
  assert(options)
  if (originalEr) {
    assert(originalEr instanceof Error)
  }
  assert(typeof cb === 'function')

  // try to rmdir first, and only readdir on ENOTEMPTY or EEXIST (SunOS)
  // if we guessed wrong, and it's not a directory, then
  // raise the original error.
  options.rmdir(p, er => {
    if (er && (er.code === 'ENOTEMPTY' || er.code === 'EEXIST' || er.code === 'EPERM')) {
      rmkids(p, options, cb)
    } else if (er && er.code === 'ENOTDIR') {
      cb(originalEr)
    } else {
      cb(er)
    }
  })
}

function rmkids (p, options, cb) {
  assert(p)
  assert(options)
  assert(typeof cb === 'function')

  options.readdir(p, (er, files) => {
    if (er) return cb(er)

    let n = files.length
    let errState

    if (n === 0) return options.rmdir(p, cb)

    files.forEach(f => {
      rimraf(path.join(p, f), options, er => {
        if (errState) {
          return
        }
        if (er) return cb(errState = er)
        if (--n === 0) {
          options.rmdir(p, cb)
        }
      })
    })
  })
}

// this looks simpler, and is strictly *faster*, but will
// tie up the JavaScript thread and fail on excessively
// deep directory trees.
function rimrafSync (p, options) {
  let st

  options = options || {}
  defaults(options)

  assert(p, 'rimraf: missing path')
  assert.equal(typeof p, 'string', 'rimraf: path should be a string')
  assert(options, 'rimraf: missing options')
  assert.equal(typeof options, 'object', 'rimraf: options should be object')

  try {
    st = options.lstatSync(p)
  } catch (er) {
    if (er.code === 'ENOENT') {
      return
    }

    // Windows can EPERM on stat.  Life is suffering.
    if (er.code === 'EPERM' && isWindows) {
      fixWinEPERMSync(p, options, er)
    }
  }

  try {
    // sunos lets the root user unlink directories, which is... weird.
    if (st && st.isDirectory()) {
      rmdirSync(p, options, null)
    } else {
      options.unlinkSync(p)
    }
  } catch (er) {
    if (er.code === 'ENOENT') {
      return
    } else if (er.code === 'EPERM') {
      return isWindows ? fixWinEPERMSync(p, options, er) : rmdirSync(p, options, er)
    } else if (er.code !== 'EISDIR') {
      throw er
    }
    rmdirSync(p, options, er)
  }
}

function rmdirSync (p, options, originalEr) {
  assert(p)
  assert(options)
  if (originalEr) {
    assert(originalEr instanceof Error)
  }

  try {
    options.rmdirSync(p)
  } catch (er) {
    if (er.code === 'ENOTDIR') {
      throw originalEr
    } else if (er.code === 'ENOTEMPTY' || er.code === 'EEXIST' || er.code === 'EPERM') {
      rmkidsSync(p, options)
    } else if (er.code !== 'ENOENT') {
      throw er
    }
  }
}

function rmkidsSync (p, options) {
  assert(p)
  assert(options)
  options.readdirSync(p).forEach(f => rimrafSync(path.join(p, f), options))

  // We only end up here once we got ENOTEMPTY at least once, and
  // at this point, we are guaranteed to have removed all the kids.
  // So, we know that it won't be ENOENT or ENOTDIR or anything else.
  // try really hard to delete stuff on windows, because it has a
  // PROFOUNDLY annoying habit of not closing handles promptly when
  // files are deleted, resulting in spurious ENOTEMPTY errors.
  const retries = isWindows ? 100 : 1
  let i = 0
  do {
    let threw = true
    try {
      const ret = options.rmdirSync(p, options)
      threw = false
      return ret
    } finally {
      if (++i < retries && threw) continue // eslint-disable-line
    }
  } while (true)
}

module.exports = rimraf
rimraf.sync = rimrafSync


/***/ }),
/* 41 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const jsonFile = __webpack_require__(10)

jsonFile.outputJson = u(__webpack_require__(43))
jsonFile.outputJsonSync = __webpack_require__(44)
// aliases
jsonFile.outputJSON = jsonFile.outputJson
jsonFile.outputJSONSync = jsonFile.outputJsonSync
jsonFile.writeJSON = jsonFile.writeJson
jsonFile.writeJSONSync = jsonFile.writeJsonSync
jsonFile.readJSON = jsonFile.readJson
jsonFile.readJSONSync = jsonFile.readJsonSync

module.exports = jsonFile


/***/ }),
/* 42 */
/***/ (function(module, exports, __webpack_require__) {

var _fs
try {
  _fs = __webpack_require__(1)
} catch (_) {
  _fs = __webpack_require__(4)
}

function readFile (file, options, callback) {
  if (callback == null) {
    callback = options
    options = {}
  }

  if (typeof options === 'string') {
    options = {encoding: options}
  }

  options = options || {}
  var fs = options.fs || _fs

  var shouldThrow = true
  if ('throws' in options) {
    shouldThrow = options.throws
  }

  fs.readFile(file, options, function (err, data) {
    if (err) return callback(err)

    data = stripBom(data)

    var obj
    try {
      obj = JSON.parse(data, options ? options.reviver : null)
    } catch (err2) {
      if (shouldThrow) {
        err2.message = file + ': ' + err2.message
        return callback(err2)
      } else {
        return callback(null, null)
      }
    }

    callback(null, obj)
  })
}

function readFileSync (file, options) {
  options = options || {}
  if (typeof options === 'string') {
    options = {encoding: options}
  }

  var fs = options.fs || _fs

  var shouldThrow = true
  if ('throws' in options) {
    shouldThrow = options.throws
  }

  try {
    var content = fs.readFileSync(file, options)
    content = stripBom(content)
    return JSON.parse(content, options.reviver)
  } catch (err) {
    if (shouldThrow) {
      err.message = file + ': ' + err.message
      throw err
    } else {
      return null
    }
  }
}

function stringify (obj, options) {
  var spaces
  var EOL = '\n'
  if (typeof options === 'object' && options !== null) {
    if (options.spaces) {
      spaces = options.spaces
    }
    if (options.EOL) {
      EOL = options.EOL
    }
  }

  var str = JSON.stringify(obj, options ? options.replacer : null, spaces)

  return str.replace(/\n/g, EOL) + EOL
}

function writeFile (file, obj, options, callback) {
  if (callback == null) {
    callback = options
    options = {}
  }
  options = options || {}
  var fs = options.fs || _fs

  var str = ''
  try {
    str = stringify(obj, options)
  } catch (err) {
    // Need to return whether a callback was passed or not
    if (callback) callback(err, null)
    return
  }

  fs.writeFile(file, str, options, callback)
}

function writeFileSync (file, obj, options) {
  options = options || {}
  var fs = options.fs || _fs

  var str = stringify(obj, options)
  // not sure if fs.writeFileSync returns anything, but just in case
  return fs.writeFileSync(file, str, options)
}

function stripBom (content) {
  // we do this because JSON.parse would convert it to a utf8 string if encoding wasn't specified
  if (Buffer.isBuffer(content)) content = content.toString('utf8')
  content = content.replace(/^\uFEFF/, '')
  return content
}

var jsonfile = {
  readFile: readFile,
  readFileSync: readFileSync,
  writeFile: writeFile,
  writeFileSync: writeFileSync
}

module.exports = jsonfile


/***/ }),
/* 43 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const path = __webpack_require__(0)
const mkdir = __webpack_require__(3)
const pathExists = __webpack_require__(5).pathExists
const jsonFile = __webpack_require__(10)

function outputJson (file, data, options, callback) {
  if (typeof options === 'function') {
    callback = options
    options = {}
  }

  const dir = path.dirname(file)

  pathExists(dir, (err, itDoes) => {
    if (err) return callback(err)
    if (itDoes) return jsonFile.writeJson(file, data, options, callback)

    mkdir.mkdirs(dir, err => {
      if (err) return callback(err)
      jsonFile.writeJson(file, data, options, callback)
    })
  })
}

module.exports = outputJson


/***/ }),
/* 44 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const mkdir = __webpack_require__(3)
const jsonFile = __webpack_require__(10)

function outputJsonSync (file, data, options) {
  const dir = path.dirname(file)

  if (!fs.existsSync(dir)) {
    mkdir.mkdirsSync(dir)
  }

  jsonFile.writeJsonSync(file, data, options)
}

module.exports = outputJsonSync


/***/ }),
/* 45 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


// most of this code was written by Andrew Kelley
// licensed under the BSD license: see
// https://github.com/andrewrk/node-mv/blob/master/package.json

// this needs a cleanup

const u = __webpack_require__(2).fromCallback
const fs = __webpack_require__(1)
const copy = __webpack_require__(16)
const path = __webpack_require__(0)
const remove = __webpack_require__(9).remove
const mkdirp = __webpack_require__(3).mkdirs

function move (src, dest, options, callback) {
  if (typeof options === 'function') {
    callback = options
    options = {}
  }

  const overwrite = options.overwrite || options.clobber || false

  isSrcSubdir(src, dest, (err, itIs) => {
    if (err) return callback(err)
    if (itIs) return callback(new Error(`Cannot move '${src}' to a subdirectory of itself, '${dest}'.`))
    mkdirp(path.dirname(dest), err => {
      if (err) return callback(err)
      doRename()
    })
  })

  function doRename () {
    if (path.resolve(src) === path.resolve(dest)) {
      fs.access(src, callback)
    } else if (overwrite) {
      fs.rename(src, dest, err => {
        if (!err) return callback()

        if (err.code === 'ENOTEMPTY' || err.code === 'EEXIST') {
          remove(dest, err => {
            if (err) return callback(err)
            options.overwrite = false // just overwriteed it, no need to do it again
            move(src, dest, options, callback)
          })
          return
        }

        // weird Windows shit
        if (err.code === 'EPERM') {
          setTimeout(() => {
            remove(dest, err => {
              if (err) return callback(err)
              options.overwrite = false
              move(src, dest, options, callback)
            })
          }, 200)
          return
        }

        if (err.code !== 'EXDEV') return callback(err)
        moveAcrossDevice(src, dest, overwrite, callback)
      })
    } else {
      fs.link(src, dest, err => {
        if (err) {
          if (err.code === 'EXDEV' || err.code === 'EISDIR' || err.code === 'EPERM' || err.code === 'ENOTSUP') {
            return moveAcrossDevice(src, dest, overwrite, callback)
          }
          return callback(err)
        }
        return fs.unlink(src, callback)
      })
    }
  }
}

function moveAcrossDevice (src, dest, overwrite, callback) {
  fs.stat(src, (err, stat) => {
    if (err) return callback(err)

    if (stat.isDirectory()) {
      moveDirAcrossDevice(src, dest, overwrite, callback)
    } else {
      moveFileAcrossDevice(src, dest, overwrite, callback)
    }
  })
}

function moveFileAcrossDevice (src, dest, overwrite, callback) {
  const flags = overwrite ? 'w' : 'wx'
  const ins = fs.createReadStream(src)
  const outs = fs.createWriteStream(dest, { flags })

  ins.on('error', err => {
    ins.destroy()
    outs.destroy()
    outs.removeListener('close', onClose)

    // may want to create a directory but `out` line above
    // creates an empty file for us: See #108
    // don't care about error here
    fs.unlink(dest, () => {
      // note: `err` here is from the input stream errror
      if (err.code === 'EISDIR' || err.code === 'EPERM') {
        moveDirAcrossDevice(src, dest, overwrite, callback)
      } else {
        callback(err)
      }
    })
  })

  outs.on('error', err => {
    ins.destroy()
    outs.destroy()
    outs.removeListener('close', onClose)
    callback(err)
  })

  outs.once('close', onClose)
  ins.pipe(outs)

  function onClose () {
    fs.unlink(src, callback)
  }
}

function moveDirAcrossDevice (src, dest, overwrite, callback) {
  const options = {
    overwrite: false
  }

  if (overwrite) {
    remove(dest, err => {
      if (err) return callback(err)
      startCopy()
    })
  } else {
    startCopy()
  }

  function startCopy () {
    copy(src, dest, options, err => {
      if (err) return callback(err)
      remove(src, callback)
    })
  }
}

// return true if dest is a subdir of src, otherwise false.
// extract dest base dir and check if that is the same as src basename
function isSrcSubdir (src, dest, cb) {
  fs.stat(src, (err, st) => {
    if (err) return cb(err)
    if (st.isDirectory()) {
      const baseDir = dest.split(path.dirname(src) + path.sep)[1]
      if (baseDir) {
        const destBasename = baseDir.split(path.sep)[0]
        if (destBasename) return cb(null, src !== dest && dest.indexOf(src) > -1 && destBasename === path.basename(src))
        return cb(null, false)
      }
      return cb(null, false)
    }
    return cb(null, false)
  })
}

module.exports = {
  move: u(move)
}


/***/ }),
/* 46 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const copySync = __webpack_require__(19).copySync
const removeSync = __webpack_require__(9).removeSync
const mkdirpSync = __webpack_require__(3).mkdirsSync
const buffer = __webpack_require__(20)

function moveSync (src, dest, options) {
  options = options || {}
  const overwrite = options.overwrite || options.clobber || false

  src = path.resolve(src)
  dest = path.resolve(dest)

  if (src === dest) return fs.accessSync(src)

  if (isSrcSubdir(src, dest)) throw new Error(`Cannot move '${src}' into itself '${dest}'.`)

  mkdirpSync(path.dirname(dest))
  tryRenameSync()

  function tryRenameSync () {
    if (overwrite) {
      try {
        return fs.renameSync(src, dest)
      } catch (err) {
        if (err.code === 'ENOTEMPTY' || err.code === 'EEXIST' || err.code === 'EPERM') {
          removeSync(dest)
          options.overwrite = false // just overwriteed it, no need to do it again
          return moveSync(src, dest, options)
        }

        if (err.code !== 'EXDEV') throw err
        return moveSyncAcrossDevice(src, dest, overwrite)
      }
    } else {
      try {
        fs.linkSync(src, dest)
        return fs.unlinkSync(src)
      } catch (err) {
        if (err.code === 'EXDEV' || err.code === 'EISDIR' || err.code === 'EPERM' || err.code === 'ENOTSUP') {
          return moveSyncAcrossDevice(src, dest, overwrite)
        }
        throw err
      }
    }
  }
}

function moveSyncAcrossDevice (src, dest, overwrite) {
  const stat = fs.statSync(src)

  if (stat.isDirectory()) {
    return moveDirSyncAcrossDevice(src, dest, overwrite)
  } else {
    return moveFileSyncAcrossDevice(src, dest, overwrite)
  }
}

function moveFileSyncAcrossDevice (src, dest, overwrite) {
  const BUF_LENGTH = 64 * 1024
  const _buff = buffer(BUF_LENGTH)

  const flags = overwrite ? 'w' : 'wx'

  const fdr = fs.openSync(src, 'r')
  const stat = fs.fstatSync(fdr)
  const fdw = fs.openSync(dest, flags, stat.mode)
  let bytesRead = 1
  let pos = 0

  while (bytesRead > 0) {
    bytesRead = fs.readSync(fdr, _buff, 0, BUF_LENGTH, pos)
    fs.writeSync(fdw, _buff, 0, bytesRead)
    pos += bytesRead
  }

  fs.closeSync(fdr)
  fs.closeSync(fdw)
  return fs.unlinkSync(src)
}

function moveDirSyncAcrossDevice (src, dest, overwrite) {
  const options = {
    overwrite: false
  }

  if (overwrite) {
    removeSync(dest)
    tryCopySync()
  } else {
    tryCopySync()
  }

  function tryCopySync () {
    copySync(src, dest, options)
    return removeSync(src)
  }
}

// return true if dest is a subdir of src, otherwise false.
// extract dest base dir and check if that is the same as src basename
function isSrcSubdir (src, dest) {
  try {
    return fs.statSync(src).isDirectory() &&
           src !== dest &&
           dest.indexOf(src) > -1 &&
           dest.split(path.dirname(src) + path.sep)[1].split(path.sep)[0] === path.basename(src)
  } catch (e) {
    return false
  }
}

module.exports = {
  moveSync
}


/***/ }),
/* 47 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const fs = __webpack_require__(4)
const path = __webpack_require__(0)
const mkdir = __webpack_require__(3)
const remove = __webpack_require__(9)

const emptyDir = u(function emptyDir (dir, callback) {
  callback = callback || function () {}
  fs.readdir(dir, (err, items) => {
    if (err) return mkdir.mkdirs(dir, callback)

    items = items.map(item => path.join(dir, item))

    deleteItem()

    function deleteItem () {
      const item = items.pop()
      if (!item) return callback()
      remove.remove(item, err => {
        if (err) return callback(err)
        deleteItem()
      })
    }
  })
})

function emptyDirSync (dir) {
  let items
  try {
    items = fs.readdirSync(dir)
  } catch (err) {
    return mkdir.mkdirsSync(dir)
  }

  items.forEach(item => {
    item = path.join(dir, item)
    remove.removeSync(item)
  })
}

module.exports = {
  emptyDirSync,
  emptydirSync: emptyDirSync,
  emptyDir,
  emptydir: emptyDir
}


/***/ }),
/* 48 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const file = __webpack_require__(49)
const link = __webpack_require__(50)
const symlink = __webpack_require__(51)

module.exports = {
  // file
  createFile: file.createFile,
  createFileSync: file.createFileSync,
  ensureFile: file.createFile,
  ensureFileSync: file.createFileSync,
  // link
  createLink: link.createLink,
  createLinkSync: link.createLinkSync,
  ensureLink: link.createLink,
  ensureLinkSync: link.createLinkSync,
  // symlink
  createSymlink: symlink.createSymlink,
  createSymlinkSync: symlink.createSymlinkSync,
  ensureSymlink: symlink.createSymlink,
  ensureSymlinkSync: symlink.createSymlinkSync
}


/***/ }),
/* 49 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const path = __webpack_require__(0)
const fs = __webpack_require__(1)
const mkdir = __webpack_require__(3)
const pathExists = __webpack_require__(5).pathExists

function createFile (file, callback) {
  function makeFile () {
    fs.writeFile(file, '', err => {
      if (err) return callback(err)
      callback()
    })
  }

  fs.stat(file, (err, stats) => { // eslint-disable-line handle-callback-err
    if (!err && stats.isFile()) return callback()
    const dir = path.dirname(file)
    pathExists(dir, (err, dirExists) => {
      if (err) return callback(err)
      if (dirExists) return makeFile()
      mkdir.mkdirs(dir, err => {
        if (err) return callback(err)
        makeFile()
      })
    })
  })
}

function createFileSync (file) {
  let stats
  try {
    stats = fs.statSync(file)
  } catch (e) {}
  if (stats && stats.isFile()) return

  const dir = path.dirname(file)
  if (!fs.existsSync(dir)) {
    mkdir.mkdirsSync(dir)
  }

  fs.writeFileSync(file, '')
}

module.exports = {
  createFile: u(createFile),
  createFileSync
}


/***/ }),
/* 50 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const path = __webpack_require__(0)
const fs = __webpack_require__(1)
const mkdir = __webpack_require__(3)
const pathExists = __webpack_require__(5).pathExists

function createLink (srcpath, dstpath, callback) {
  function makeLink (srcpath, dstpath) {
    fs.link(srcpath, dstpath, err => {
      if (err) return callback(err)
      callback(null)
    })
  }

  pathExists(dstpath, (err, destinationExists) => {
    if (err) return callback(err)
    if (destinationExists) return callback(null)
    fs.lstat(srcpath, (err, stat) => {
      if (err) {
        err.message = err.message.replace('lstat', 'ensureLink')
        return callback(err)
      }

      const dir = path.dirname(dstpath)
      pathExists(dir, (err, dirExists) => {
        if (err) return callback(err)
        if (dirExists) return makeLink(srcpath, dstpath)
        mkdir.mkdirs(dir, err => {
          if (err) return callback(err)
          makeLink(srcpath, dstpath)
        })
      })
    })
  })
}

function createLinkSync (srcpath, dstpath, callback) {
  const destinationExists = fs.existsSync(dstpath)
  if (destinationExists) return undefined

  try {
    fs.lstatSync(srcpath)
  } catch (err) {
    err.message = err.message.replace('lstat', 'ensureLink')
    throw err
  }

  const dir = path.dirname(dstpath)
  const dirExists = fs.existsSync(dir)
  if (dirExists) return fs.linkSync(srcpath, dstpath)
  mkdir.mkdirsSync(dir)

  return fs.linkSync(srcpath, dstpath)
}

module.exports = {
  createLink: u(createLink),
  createLinkSync
}


/***/ }),
/* 51 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const path = __webpack_require__(0)
const fs = __webpack_require__(1)
const _mkdirs = __webpack_require__(3)
const mkdirs = _mkdirs.mkdirs
const mkdirsSync = _mkdirs.mkdirsSync

const _symlinkPaths = __webpack_require__(52)
const symlinkPaths = _symlinkPaths.symlinkPaths
const symlinkPathsSync = _symlinkPaths.symlinkPathsSync

const _symlinkType = __webpack_require__(53)
const symlinkType = _symlinkType.symlinkType
const symlinkTypeSync = _symlinkType.symlinkTypeSync

const pathExists = __webpack_require__(5).pathExists

function createSymlink (srcpath, dstpath, type, callback) {
  callback = (typeof type === 'function') ? type : callback
  type = (typeof type === 'function') ? false : type

  pathExists(dstpath, (err, destinationExists) => {
    if (err) return callback(err)
    if (destinationExists) return callback(null)
    symlinkPaths(srcpath, dstpath, (err, relative) => {
      if (err) return callback(err)
      srcpath = relative.toDst
      symlinkType(relative.toCwd, type, (err, type) => {
        if (err) return callback(err)
        const dir = path.dirname(dstpath)
        pathExists(dir, (err, dirExists) => {
          if (err) return callback(err)
          if (dirExists) return fs.symlink(srcpath, dstpath, type, callback)
          mkdirs(dir, err => {
            if (err) return callback(err)
            fs.symlink(srcpath, dstpath, type, callback)
          })
        })
      })
    })
  })
}

function createSymlinkSync (srcpath, dstpath, type, callback) {
  callback = (typeof type === 'function') ? type : callback
  type = (typeof type === 'function') ? false : type

  const destinationExists = fs.existsSync(dstpath)
  if (destinationExists) return undefined

  const relative = symlinkPathsSync(srcpath, dstpath)
  srcpath = relative.toDst
  type = symlinkTypeSync(relative.toCwd, type)
  const dir = path.dirname(dstpath)
  const exists = fs.existsSync(dir)
  if (exists) return fs.symlinkSync(srcpath, dstpath, type)
  mkdirsSync(dir)
  return fs.symlinkSync(srcpath, dstpath, type)
}

module.exports = {
  createSymlink: u(createSymlink),
  createSymlinkSync
}


/***/ }),
/* 52 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const path = __webpack_require__(0)
const fs = __webpack_require__(1)
const pathExists = __webpack_require__(5).pathExists

/**
 * Function that returns two types of paths, one relative to symlink, and one
 * relative to the current working directory. Checks if path is absolute or
 * relative. If the path is relative, this function checks if the path is
 * relative to symlink or relative to current working directory. This is an
 * initiative to find a smarter `srcpath` to supply when building symlinks.
 * This allows you to determine which path to use out of one of three possible
 * types of source paths. The first is an absolute path. This is detected by
 * `path.isAbsolute()`. When an absolute path is provided, it is checked to
 * see if it exists. If it does it's used, if not an error is returned
 * (callback)/ thrown (sync). The other two options for `srcpath` are a
 * relative url. By default Node's `fs.symlink` works by creating a symlink
 * using `dstpath` and expects the `srcpath` to be relative to the newly
 * created symlink. If you provide a `srcpath` that does not exist on the file
 * system it results in a broken symlink. To minimize this, the function
 * checks to see if the 'relative to symlink' source file exists, and if it
 * does it will use it. If it does not, it checks if there's a file that
 * exists that is relative to the current working directory, if does its used.
 * This preserves the expectations of the original fs.symlink spec and adds
 * the ability to pass in `relative to current working direcotry` paths.
 */

function symlinkPaths (srcpath, dstpath, callback) {
  if (path.isAbsolute(srcpath)) {
    return fs.lstat(srcpath, (err, stat) => {
      if (err) {
        err.message = err.message.replace('lstat', 'ensureSymlink')
        return callback(err)
      }
      return callback(null, {
        'toCwd': srcpath,
        'toDst': srcpath
      })
    })
  } else {
    const dstdir = path.dirname(dstpath)
    const relativeToDst = path.join(dstdir, srcpath)
    return pathExists(relativeToDst, (err, exists) => {
      if (err) return callback(err)
      if (exists) {
        return callback(null, {
          'toCwd': relativeToDst,
          'toDst': srcpath
        })
      } else {
        return fs.lstat(srcpath, (err, stat) => {
          if (err) {
            err.message = err.message.replace('lstat', 'ensureSymlink')
            return callback(err)
          }
          return callback(null, {
            'toCwd': srcpath,
            'toDst': path.relative(dstdir, srcpath)
          })
        })
      }
    })
  }
}

function symlinkPathsSync (srcpath, dstpath) {
  let exists
  if (path.isAbsolute(srcpath)) {
    exists = fs.existsSync(srcpath)
    if (!exists) throw new Error('absolute srcpath does not exist')
    return {
      'toCwd': srcpath,
      'toDst': srcpath
    }
  } else {
    const dstdir = path.dirname(dstpath)
    const relativeToDst = path.join(dstdir, srcpath)
    exists = fs.existsSync(relativeToDst)
    if (exists) {
      return {
        'toCwd': relativeToDst,
        'toDst': srcpath
      }
    } else {
      exists = fs.existsSync(srcpath)
      if (!exists) throw new Error('relative srcpath does not exist')
      return {
        'toCwd': srcpath,
        'toDst': path.relative(dstdir, srcpath)
      }
    }
  }
}

module.exports = {
  symlinkPaths,
  symlinkPathsSync
}


/***/ }),
/* 53 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const fs = __webpack_require__(1)

function symlinkType (srcpath, type, callback) {
  callback = (typeof type === 'function') ? type : callback
  type = (typeof type === 'function') ? false : type
  if (type) return callback(null, type)
  fs.lstat(srcpath, (err, stats) => {
    if (err) return callback(null, 'file')
    type = (stats && stats.isDirectory()) ? 'dir' : 'file'
    callback(null, type)
  })
}

function symlinkTypeSync (srcpath, type) {
  let stats

  if (type) return type
  try {
    stats = fs.lstatSync(srcpath)
  } catch (e) {
    return 'file'
  }
  return (stats && stats.isDirectory()) ? 'dir' : 'file'
}

module.exports = {
  symlinkType,
  symlinkTypeSync
}


/***/ }),
/* 54 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


const u = __webpack_require__(2).fromCallback
const fs = __webpack_require__(1)
const path = __webpack_require__(0)
const mkdir = __webpack_require__(3)
const pathExists = __webpack_require__(5).pathExists

function outputFile (file, data, encoding, callback) {
  if (typeof encoding === 'function') {
    callback = encoding
    encoding = 'utf8'
  }

  const dir = path.dirname(file)
  pathExists(dir, (err, itDoes) => {
    if (err) return callback(err)
    if (itDoes) return fs.writeFile(file, data, encoding, callback)

    mkdir.mkdirs(dir, err => {
      if (err) return callback(err)

      fs.writeFile(file, data, encoding, callback)
    })
  })
}

function outputFileSync (file, data, encoding) {
  const dir = path.dirname(file)
  if (fs.existsSync(dir)) {
    return fs.writeFileSync.apply(fs, arguments)
  }
  mkdir.mkdirsSync(dir)
  fs.writeFileSync.apply(fs, arguments)
}

module.exports = {
  outputFile: u(outputFile),
  outputFileSync
}


/***/ }),
/* 55 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __assign = (this && this.__assign) || Object.assign || function(t) {
    for (var s, i = 1, n = arguments.length; i < n; i++) {
        s = arguments[i];
        for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
            t[p] = s[p];
    }
    return t;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = y[op[0] & 2 ? "return" : op[0] ? "throw" : "next"]) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [0, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) if (e.indexOf(p[i]) < 0)
            t[p[i]] = s[p[i]];
    return t;
};
Object.defineProperty(exports, "__esModule", { value: true });
var types_1 = __webpack_require__(21);
var types_2 = __webpack_require__(21);
exports.ClientError = types_2.ClientError;
__webpack_require__(56);
var GraphQLClient = /** @class */ (function () {
    function GraphQLClient(url, options) {
        this.url = url;
        this.options = options || {};
    }
    GraphQLClient.prototype.rawRequest = function (query, variables) {
        return __awaiter(this, void 0, void 0, function () {
            var _a, headers, others, body, response, result, headers_1, status_1, errorResult;
            return __generator(this, function (_b) {
                switch (_b.label) {
                    case 0:
                        _a = this.options, headers = _a.headers, others = __rest(_a, ["headers"]);
                        body = JSON.stringify({
                            query: query,
                            variables: variables ? variables : undefined,
                        });
                        return [4 /*yield*/, fetch(this.url, __assign({ method: 'POST', headers: Object.assign({ 'Content-Type': 'application/json' }, headers), body: body }, others))];
                    case 1:
                        response = _b.sent();
                        return [4 /*yield*/, getResult(response)];
                    case 2:
                        result = _b.sent();
                        if (response.ok && !result.errors && result.data) {
                            headers_1 = response.headers, status_1 = response.status;
                            return [2 /*return*/, __assign({}, result, { headers: headers_1, status: status_1 })];
                        }
                        else {
                            errorResult = typeof result === 'string' ? { error: result } : result;
                            throw new types_1.ClientError(__assign({}, errorResult, { status: response.status, headers: response.headers }), { query: query, variables: variables });
                        }
                        return [2 /*return*/];
                }
            });
        });
    };
    GraphQLClient.prototype.request = function (query, variables) {
        return __awaiter(this, void 0, void 0, function () {
            var _a, headers, others, body, response, result, errorResult;
            return __generator(this, function (_b) {
                switch (_b.label) {
                    case 0:
                        _a = this.options, headers = _a.headers, others = __rest(_a, ["headers"]);
                        body = JSON.stringify({
                            query: query,
                            variables: variables ? variables : undefined,
                        });
                        return [4 /*yield*/, fetch(this.url, __assign({ method: 'POST', headers: Object.assign({ 'Content-Type': 'application/json' }, headers), body: body }, others))];
                    case 1:
                        response = _b.sent();
                        return [4 /*yield*/, getResult(response)];
                    case 2:
                        result = _b.sent();
                        if (response.ok && !result.errors && result.data) {
                            return [2 /*return*/, result.data];
                        }
                        else {
                            errorResult = typeof result === 'string' ? { error: result } : result;
                            throw new types_1.ClientError(__assign({}, errorResult, { status: response.status }), { query: query, variables: variables });
                        }
                        return [2 /*return*/];
                }
            });
        });
    };
    GraphQLClient.prototype.setHeaders = function (headers) {
        this.options.headers = headers;
        return this;
    };
    GraphQLClient.prototype.setHeader = function (key, value) {
        var headers = this.options.headers;
        if (headers) {
            headers[key] = value;
        }
        else {
            this.options.headers = (_a = {}, _a[key] = value, _a);
        }
        return this;
        var _a;
    };
    return GraphQLClient;
}());
exports.GraphQLClient = GraphQLClient;
function rawRequest(url, query, variables) {
    return __awaiter(this, void 0, void 0, function () {
        var client;
        return __generator(this, function (_a) {
            client = new GraphQLClient(url);
            return [2 /*return*/, client.rawRequest(query, variables)];
        });
    });
}
exports.rawRequest = rawRequest;
function request(url, query, variables) {
    return __awaiter(this, void 0, void 0, function () {
        var client;
        return __generator(this, function (_a) {
            client = new GraphQLClient(url);
            return [2 /*return*/, client.request(query, variables)];
        });
    });
}
exports.request = request;
exports.default = request;
function getResult(response) {
    return __awaiter(this, void 0, void 0, function () {
        var contentType;
        return __generator(this, function (_a) {
            contentType = response.headers.get('Content-Type');
            if (contentType && contentType.startsWith('application/json')) {
                return [2 /*return*/, response.json()];
            }
            else {
                return [2 /*return*/, response.text()];
            }
            return [2 /*return*/];
        });
    });
}
//# sourceMappingURL=index.js.map

/***/ }),
/* 56 */
/***/ (function(module, exports, __webpack_require__) {

var fetchNode = __webpack_require__(57);
var fetch = fetchNode.fetch.bind({});

fetch.polyfill = true;

if (!global.fetch) {
  global.fetch = fetch;
  global.Response = fetchNode.Response;
  global.Headers = fetchNode.Headers;
  global.Request = fetchNode.Request;
}



/***/ }),
/* 57 */
/***/ (function(module, exports, __webpack_require__) {

var nodeFetch = __webpack_require__(58);
var realFetch = nodeFetch.default || nodeFetch;

var fetch = function (url, options) {
  // Support schemaless URIs on the server for parity with the browser.
  // Ex: //github.com/ -> https://github.com/
  if (/^\/\//.test(url)) {
    url = 'https:' + url;
  }
  return realFetch.call(this, url, options);
};

fetch.polyfill = false;

module.exports = exports = fetch;
exports.fetch = fetch;
exports.Headers = nodeFetch.Headers;
exports.Request = nodeFetch.Request;
exports.Response = nodeFetch.Response;

// Needed for TypeScript.
exports.default = fetch;


/***/ }),
/* 58 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "Headers", function() { return Headers; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "Request", function() { return Request; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "Response", function() { return Response; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "FetchError", function() { return FetchError; });
// Based on https://github.com/tmpvar/jsdom/blob/aa85b2abf07766ff7bf5c1f6daafb3726f2f2db5/lib/jsdom/living/blob.js
// (MIT licensed)

const BUFFER = Symbol('buffer');
const TYPE = Symbol('type');

class Blob {
	constructor() {
		this[TYPE] = '';

		const blobParts = arguments[0];
		const options = arguments[1];

		const buffers = [];

		if (blobParts) {
			const a = blobParts;
			const length = Number(a.length);
			for (let i = 0; i < length; i++) {
				const element = a[i];
				let buffer;
				if (element instanceof Buffer) {
					buffer = element;
				} else if (ArrayBuffer.isView(element)) {
					buffer = Buffer.from(element.buffer, element.byteOffset, element.byteLength);
				} else if (element instanceof ArrayBuffer) {
					buffer = Buffer.from(element);
				} else if (element instanceof Blob) {
					buffer = element[BUFFER];
				} else {
					buffer = Buffer.from(typeof element === 'string' ? element : String(element));
				}
				buffers.push(buffer);
			}
		}

		this[BUFFER] = Buffer.concat(buffers);

		let type = options && options.type !== undefined && String(options.type).toLowerCase();
		if (type && !/[^\u0020-\u007E]/.test(type)) {
			this[TYPE] = type;
		}
	}
	get size() {
		return this[BUFFER].length;
	}
	get type() {
		return this[TYPE];
	}
	slice() {
		const size = this.size;

		const start = arguments[0];
		const end = arguments[1];
		let relativeStart, relativeEnd;
		if (start === undefined) {
			relativeStart = 0;
		} else if (start < 0) {
			relativeStart = Math.max(size + start, 0);
		} else {
			relativeStart = Math.min(start, size);
		}
		if (end === undefined) {
			relativeEnd = size;
		} else if (end < 0) {
			relativeEnd = Math.max(size + end, 0);
		} else {
			relativeEnd = Math.min(end, size);
		}
		const span = Math.max(relativeEnd - relativeStart, 0);

		const buffer = this[BUFFER];
		const slicedBuffer = buffer.slice(relativeStart, relativeStart + span);
		const blob = new Blob([], { type: arguments[2] });
		blob[BUFFER] = slicedBuffer;
		return blob;
	}
}

Object.defineProperties(Blob.prototype, {
	size: { enumerable: true },
	type: { enumerable: true },
	slice: { enumerable: true }
});

Object.defineProperty(Blob.prototype, Symbol.toStringTag, {
	value: 'Blob',
	writable: false,
	enumerable: false,
	configurable: true
});

/**
 * fetch-error.js
 *
 * FetchError interface for operational errors
 */

/**
 * Create FetchError instance
 *
 * @param   String      message      Error message for human
 * @param   String      type         Error type for machine
 * @param   String      systemError  For Node.js system error
 * @return  FetchError
 */
function FetchError(message, type, systemError) {
  Error.call(this, message);

  this.message = message;
  this.type = type;

  // when err.type is `system`, err.code contains system error code
  if (systemError) {
    this.code = this.errno = systemError.code;
  }

  // hide custom error implementation details from end-users
  Error.captureStackTrace(this, this.constructor);
}

FetchError.prototype = Object.create(Error.prototype);
FetchError.prototype.constructor = FetchError;
FetchError.prototype.name = 'FetchError';

/**
 * body.js
 *
 * Body interface provides common methods for Request and Response
 */

const Stream = __webpack_require__(6);

var _require = __webpack_require__(6);

const PassThrough = _require.PassThrough;


let convert;
try {
	convert = __webpack_require__(!(function webpackMissingModule() { var e = new Error("Cannot find module \"encoding\""); e.code = 'MODULE_NOT_FOUND'; throw e; }())).convert;
} catch (e) {}

const INTERNALS = Symbol('Body internals');

/**
 * Body mixin
 *
 * Ref: https://fetch.spec.whatwg.org/#body
 *
 * @param   Stream  body  Readable stream
 * @param   Object  opts  Response options
 * @return  Void
 */
function Body(body) {
	var _this = this;

	var _ref = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
	    _ref$size = _ref.size;

	let size = _ref$size === undefined ? 0 : _ref$size;
	var _ref$timeout = _ref.timeout;
	let timeout = _ref$timeout === undefined ? 0 : _ref$timeout;

	if (body == null) {
		// body is undefined or null
		body = null;
	} else if (typeof body === 'string') {
		// body is string
	} else if (isURLSearchParams(body)) {
		// body is a URLSearchParams
	} else if (body instanceof Blob) {
		// body is blob
	} else if (Buffer.isBuffer(body)) {
		// body is buffer
	} else if (Object.prototype.toString.call(body) === '[object ArrayBuffer]') {
		// body is array buffer
	} else if (body instanceof Stream) {
		// body is stream
	} else {
		// none of the above
		// coerce to string
		body = String(body);
	}
	this[INTERNALS] = {
		body,
		disturbed: false,
		error: null
	};
	this.size = size;
	this.timeout = timeout;

	if (body instanceof Stream) {
		body.on('error', function (err) {
			_this[INTERNALS].error = new FetchError(`Invalid response body while trying to fetch ${_this.url}: ${err.message}`, 'system', err);
		});
	}
}

Body.prototype = {
	get body() {
		return this[INTERNALS].body;
	},

	get bodyUsed() {
		return this[INTERNALS].disturbed;
	},

	/**
  * Decode response as ArrayBuffer
  *
  * @return  Promise
  */
	arrayBuffer() {
		return consumeBody.call(this).then(function (buf) {
			return buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength);
		});
	},

	/**
  * Return raw response as Blob
  *
  * @return Promise
  */
	blob() {
		let ct = this.headers && this.headers.get('content-type') || '';
		return consumeBody.call(this).then(function (buf) {
			return Object.assign(
			// Prevent copying
			new Blob([], {
				type: ct.toLowerCase()
			}), {
				[BUFFER]: buf
			});
		});
	},

	/**
  * Decode response as json
  *
  * @return  Promise
  */
	json() {
		var _this2 = this;

		return consumeBody.call(this).then(function (buffer) {
			try {
				return JSON.parse(buffer.toString());
			} catch (err) {
				return Body.Promise.reject(new FetchError(`invalid json response body at ${_this2.url} reason: ${err.message}`, 'invalid-json'));
			}
		});
	},

	/**
  * Decode response as text
  *
  * @return  Promise
  */
	text() {
		return consumeBody.call(this).then(function (buffer) {
			return buffer.toString();
		});
	},

	/**
  * Decode response as buffer (non-spec api)
  *
  * @return  Promise
  */
	buffer() {
		return consumeBody.call(this);
	},

	/**
  * Decode response as text, while automatically detecting the encoding and
  * trying to decode to UTF-8 (non-spec api)
  *
  * @return  Promise
  */
	textConverted() {
		var _this3 = this;

		return consumeBody.call(this).then(function (buffer) {
			return convertBody(buffer, _this3.headers);
		});
	}

};

// In browsers, all properties are enumerable.
Object.defineProperties(Body.prototype, {
	body: { enumerable: true },
	bodyUsed: { enumerable: true },
	arrayBuffer: { enumerable: true },
	blob: { enumerable: true },
	json: { enumerable: true },
	text: { enumerable: true }
});

Body.mixIn = function (proto) {
	for (const name of Object.getOwnPropertyNames(Body.prototype)) {
		// istanbul ignore else: future proof
		if (!(name in proto)) {
			const desc = Object.getOwnPropertyDescriptor(Body.prototype, name);
			Object.defineProperty(proto, name, desc);
		}
	}
};

/**
 * Consume and convert an entire Body to a Buffer.
 *
 * Ref: https://fetch.spec.whatwg.org/#concept-body-consume-body
 *
 * @return  Promise
 */
function consumeBody() {
	var _this4 = this;

	if (this[INTERNALS].disturbed) {
		return Body.Promise.reject(new TypeError(`body used already for: ${this.url}`));
	}

	this[INTERNALS].disturbed = true;

	if (this[INTERNALS].error) {
		return Body.Promise.reject(this[INTERNALS].error);
	}

	// body is null
	if (this.body === null) {
		return Body.Promise.resolve(Buffer.alloc(0));
	}

	// body is string
	if (typeof this.body === 'string') {
		return Body.Promise.resolve(Buffer.from(this.body));
	}

	// body is blob
	if (this.body instanceof Blob) {
		return Body.Promise.resolve(this.body[BUFFER]);
	}

	// body is buffer
	if (Buffer.isBuffer(this.body)) {
		return Body.Promise.resolve(this.body);
	}

	// body is buffer
	if (Object.prototype.toString.call(this.body) === '[object ArrayBuffer]') {
		return Body.Promise.resolve(Buffer.from(this.body));
	}

	// istanbul ignore if: should never happen
	if (!(this.body instanceof Stream)) {
		return Body.Promise.resolve(Buffer.alloc(0));
	}

	// body is stream
	// get ready to actually consume the body
	let accum = [];
	let accumBytes = 0;
	let abort = false;

	return new Body.Promise(function (resolve, reject) {
		let resTimeout;

		// allow timeout on slow response body
		if (_this4.timeout) {
			resTimeout = setTimeout(function () {
				abort = true;
				reject(new FetchError(`Response timeout while trying to fetch ${_this4.url} (over ${_this4.timeout}ms)`, 'body-timeout'));
			}, _this4.timeout);
		}

		// handle stream error, such as incorrect content-encoding
		_this4.body.on('error', function (err) {
			reject(new FetchError(`Invalid response body while trying to fetch ${_this4.url}: ${err.message}`, 'system', err));
		});

		_this4.body.on('data', function (chunk) {
			if (abort || chunk === null) {
				return;
			}

			if (_this4.size && accumBytes + chunk.length > _this4.size) {
				abort = true;
				reject(new FetchError(`content size at ${_this4.url} over limit: ${_this4.size}`, 'max-size'));
				return;
			}

			accumBytes += chunk.length;
			accum.push(chunk);
		});

		_this4.body.on('end', function () {
			if (abort) {
				return;
			}

			clearTimeout(resTimeout);

			try {
				resolve(Buffer.concat(accum));
			} catch (err) {
				// handle streams that have accumulated too much data (issue #414)
				reject(new FetchError(`Could not create Buffer from response body for ${_this4.url}: ${err.message}`, 'system', err));
			}
		});
	});
}

/**
 * Detect buffer encoding and convert to target encoding
 * ref: http://www.w3.org/TR/2011/WD-html5-20110113/parsing.html#determining-the-character-encoding
 *
 * @param   Buffer  buffer    Incoming buffer
 * @param   String  encoding  Target encoding
 * @return  String
 */
function convertBody(buffer, headers) {
	if (typeof convert !== 'function') {
		throw new Error('The package `encoding` must be installed to use the textConverted() function');
	}

	const ct = headers.get('content-type');
	let charset = 'utf-8';
	let res, str;

	// header
	if (ct) {
		res = /charset=([^;]*)/i.exec(ct);
	}

	// no charset in content type, peek at response body for at most 1024 bytes
	str = buffer.slice(0, 1024).toString();

	// html5
	if (!res && str) {
		res = /<meta.+?charset=(['"])(.+?)\1/i.exec(str);
	}

	// html4
	if (!res && str) {
		res = /<meta[\s]+?http-equiv=(['"])content-type\1[\s]+?content=(['"])(.+?)\2/i.exec(str);

		if (res) {
			res = /charset=(.*)/i.exec(res.pop());
		}
	}

	// xml
	if (!res && str) {
		res = /<\?xml.+?encoding=(['"])(.+?)\1/i.exec(str);
	}

	// found charset
	if (res) {
		charset = res.pop();

		// prevent decode issues when sites use incorrect encoding
		// ref: https://hsivonen.fi/encoding-menu/
		if (charset === 'gb2312' || charset === 'gbk') {
			charset = 'gb18030';
		}
	}

	// turn raw buffers into a single utf-8 buffer
	return convert(buffer, 'UTF-8', charset).toString();
}

/**
 * Detect a URLSearchParams object
 * ref: https://github.com/bitinn/node-fetch/issues/296#issuecomment-307598143
 *
 * @param   Object  obj     Object to detect by type or brand
 * @return  String
 */
function isURLSearchParams(obj) {
	// Duck-typing as a necessary condition.
	if (typeof obj !== 'object' || typeof obj.append !== 'function' || typeof obj.delete !== 'function' || typeof obj.get !== 'function' || typeof obj.getAll !== 'function' || typeof obj.has !== 'function' || typeof obj.set !== 'function') {
		return false;
	}

	// Brand-checking and more duck-typing as optional condition.
	return obj.constructor.name === 'URLSearchParams' || Object.prototype.toString.call(obj) === '[object URLSearchParams]' || typeof obj.sort === 'function';
}

/**
 * Clone body given Res/Req instance
 *
 * @param   Mixed  instance  Response or Request instance
 * @return  Mixed
 */
function clone(instance) {
	let p1, p2;
	let body = instance.body;

	// don't allow cloning a used body
	if (instance.bodyUsed) {
		throw new Error('cannot clone body after it is used');
	}

	// check that body is a stream and not form-data object
	// note: we can't clone the form-data object without having it as a dependency
	if (body instanceof Stream && typeof body.getBoundary !== 'function') {
		// tee instance body
		p1 = new PassThrough();
		p2 = new PassThrough();
		body.pipe(p1);
		body.pipe(p2);
		// set instance body to teed body and return the other teed body
		instance[INTERNALS].body = p1;
		body = p2;
	}

	return body;
}

/**
 * Performs the operation "extract a `Content-Type` value from |object|" as
 * specified in the specification:
 * https://fetch.spec.whatwg.org/#concept-bodyinit-extract
 *
 * This function assumes that instance.body is present.
 *
 * @param   Mixed  instance  Response or Request instance
 */
function extractContentType(instance) {
	const body = instance.body;

	// istanbul ignore if: Currently, because of a guard in Request, body
	// can never be null. Included here for completeness.

	if (body === null) {
		// body is null
		return null;
	} else if (typeof body === 'string') {
		// body is string
		return 'text/plain;charset=UTF-8';
	} else if (isURLSearchParams(body)) {
		// body is a URLSearchParams
		return 'application/x-www-form-urlencoded;charset=UTF-8';
	} else if (body instanceof Blob) {
		// body is blob
		return body.type || null;
	} else if (Buffer.isBuffer(body)) {
		// body is buffer
		return null;
	} else if (Object.prototype.toString.call(body) === '[object ArrayBuffer]') {
		// body is array buffer
		return null;
	} else if (typeof body.getBoundary === 'function') {
		// detect form data input from form-data module
		return `multipart/form-data;boundary=${body.getBoundary()}`;
	} else {
		// body is stream
		// can't really do much about this
		return null;
	}
}

/**
 * The Fetch Standard treats this as if "total bytes" is a property on the body.
 * For us, we have to explicitly get it with a function.
 *
 * ref: https://fetch.spec.whatwg.org/#concept-body-total-bytes
 *
 * @param   Body    instance   Instance of Body
 * @return  Number?            Number of bytes, or null if not possible
 */
function getTotalBytes(instance) {
	const body = instance.body;

	// istanbul ignore if: included for completion

	if (body === null) {
		// body is null
		return 0;
	} else if (typeof body === 'string') {
		// body is string
		return Buffer.byteLength(body);
	} else if (isURLSearchParams(body)) {
		// body is URLSearchParams
		return Buffer.byteLength(String(body));
	} else if (body instanceof Blob) {
		// body is blob
		return body.size;
	} else if (Buffer.isBuffer(body)) {
		// body is buffer
		return body.length;
	} else if (Object.prototype.toString.call(body) === '[object ArrayBuffer]') {
		// body is array buffer
		return body.byteLength;
	} else if (body && typeof body.getLengthSync === 'function') {
		// detect form data input from form-data module
		if (body._lengthRetrievers && body._lengthRetrievers.length == 0 || // 1.x
		body.hasKnownLength && body.hasKnownLength()) {
			// 2.x
			return body.getLengthSync();
		}
		return null;
	} else {
		// body is stream
		// can't really do much about this
		return null;
	}
}

/**
 * Write a Body to a Node.js WritableStream (e.g. http.Request) object.
 *
 * @param   Body    instance   Instance of Body
 * @return  Void
 */
function writeToStream(dest, instance) {
	const body = instance.body;


	if (body === null) {
		// body is null
		dest.end();
	} else if (typeof body === 'string') {
		// body is string
		dest.write(body);
		dest.end();
	} else if (isURLSearchParams(body)) {
		// body is URLSearchParams
		dest.write(Buffer.from(String(body)));
		dest.end();
	} else if (body instanceof Blob) {
		// body is blob
		dest.write(body[BUFFER]);
		dest.end();
	} else if (Buffer.isBuffer(body)) {
		// body is buffer
		dest.write(body);
		dest.end();
	} else if (Object.prototype.toString.call(body) === '[object ArrayBuffer]') {
		// body is array buffer
		dest.write(Buffer.from(body));
		dest.end();
	} else {
		// body is stream
		body.pipe(dest);
	}
}

// expose Promise
Body.Promise = global.Promise;

/**
 * headers.js
 *
 * Headers class offers convenient helpers
 */

const invalidTokenRegex = /[^\^_`a-zA-Z\-0-9!#$%&'*+.|~]/;
const invalidHeaderCharRegex = /[^\t\x20-\x7e\x80-\xff]/;

function validateName(name) {
	name = `${name}`;
	if (invalidTokenRegex.test(name)) {
		throw new TypeError(`${name} is not a legal HTTP header name`);
	}
}

function validateValue(value) {
	value = `${value}`;
	if (invalidHeaderCharRegex.test(value)) {
		throw new TypeError(`${value} is not a legal HTTP header value`);
	}
}

/**
 * Find the key in the map object given a header name.
 *
 * Returns undefined if not found.
 *
 * @param   String  name  Header name
 * @return  String|Undefined
 */
function find(map, name) {
	name = name.toLowerCase();
	for (const key in map) {
		if (key.toLowerCase() === name) {
			return key;
		}
	}
	return undefined;
}

const MAP = Symbol('map');
class Headers {
	/**
  * Headers class
  *
  * @param   Object  headers  Response headers
  * @return  Void
  */
	constructor() {
		let init = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : undefined;

		this[MAP] = Object.create(null);

		if (init instanceof Headers) {
			const rawHeaders = init.raw();
			const headerNames = Object.keys(rawHeaders);

			for (const headerName of headerNames) {
				for (const value of rawHeaders[headerName]) {
					this.append(headerName, value);
				}
			}

			return;
		}

		// We don't worry about converting prop to ByteString here as append()
		// will handle it.
		if (init == null) {
			// no op
		} else if (typeof init === 'object') {
			const method = init[Symbol.iterator];
			if (method != null) {
				if (typeof method !== 'function') {
					throw new TypeError('Header pairs must be iterable');
				}

				// sequence<sequence<ByteString>>
				// Note: per spec we have to first exhaust the lists then process them
				const pairs = [];
				for (const pair of init) {
					if (typeof pair !== 'object' || typeof pair[Symbol.iterator] !== 'function') {
						throw new TypeError('Each header pair must be iterable');
					}
					pairs.push(Array.from(pair));
				}

				for (const pair of pairs) {
					if (pair.length !== 2) {
						throw new TypeError('Each header pair must be a name/value tuple');
					}
					this.append(pair[0], pair[1]);
				}
			} else {
				// record<ByteString, ByteString>
				for (const key of Object.keys(init)) {
					const value = init[key];
					this.append(key, value);
				}
			}
		} else {
			throw new TypeError('Provided initializer must be an object');
		}
	}

	/**
  * Return combined header value given name
  *
  * @param   String  name  Header name
  * @return  Mixed
  */
	get(name) {
		name = `${name}`;
		validateName(name);
		const key = find(this[MAP], name);
		if (key === undefined) {
			return null;
		}

		return this[MAP][key].join(', ');
	}

	/**
  * Iterate over all headers
  *
  * @param   Function  callback  Executed for each item with parameters (value, name, thisArg)
  * @param   Boolean   thisArg   `this` context for callback function
  * @return  Void
  */
	forEach(callback) {
		let thisArg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : undefined;

		let pairs = getHeaders(this);
		let i = 0;
		while (i < pairs.length) {
			var _pairs$i = pairs[i];
			const name = _pairs$i[0],
			      value = _pairs$i[1];

			callback.call(thisArg, value, name, this);
			pairs = getHeaders(this);
			i++;
		}
	}

	/**
  * Overwrite header values given name
  *
  * @param   String  name   Header name
  * @param   String  value  Header value
  * @return  Void
  */
	set(name, value) {
		name = `${name}`;
		value = `${value}`;
		validateName(name);
		validateValue(value);
		const key = find(this[MAP], name);
		this[MAP][key !== undefined ? key : name] = [value];
	}

	/**
  * Append a value onto existing header
  *
  * @param   String  name   Header name
  * @param   String  value  Header value
  * @return  Void
  */
	append(name, value) {
		name = `${name}`;
		value = `${value}`;
		validateName(name);
		validateValue(value);
		const key = find(this[MAP], name);
		if (key !== undefined) {
			this[MAP][key].push(value);
		} else {
			this[MAP][name] = [value];
		}
	}

	/**
  * Check for header name existence
  *
  * @param   String   name  Header name
  * @return  Boolean
  */
	has(name) {
		name = `${name}`;
		validateName(name);
		return find(this[MAP], name) !== undefined;
	}

	/**
  * Delete all header values given name
  *
  * @param   String  name  Header name
  * @return  Void
  */
	delete(name) {
		name = `${name}`;
		validateName(name);
		const key = find(this[MAP], name);
		if (key !== undefined) {
			delete this[MAP][key];
		}
	}

	/**
  * Return raw headers (non-spec api)
  *
  * @return  Object
  */
	raw() {
		return this[MAP];
	}

	/**
  * Get an iterator on keys.
  *
  * @return  Iterator
  */
	keys() {
		return createHeadersIterator(this, 'key');
	}

	/**
  * Get an iterator on values.
  *
  * @return  Iterator
  */
	values() {
		return createHeadersIterator(this, 'value');
	}

	/**
  * Get an iterator on entries.
  *
  * This is the default iterator of the Headers object.
  *
  * @return  Iterator
  */
	[Symbol.iterator]() {
		return createHeadersIterator(this, 'key+value');
	}
}
Headers.prototype.entries = Headers.prototype[Symbol.iterator];

Object.defineProperty(Headers.prototype, Symbol.toStringTag, {
	value: 'Headers',
	writable: false,
	enumerable: false,
	configurable: true
});

Object.defineProperties(Headers.prototype, {
	get: { enumerable: true },
	forEach: { enumerable: true },
	set: { enumerable: true },
	append: { enumerable: true },
	has: { enumerable: true },
	delete: { enumerable: true },
	keys: { enumerable: true },
	values: { enumerable: true },
	entries: { enumerable: true }
});

function getHeaders(headers) {
	let kind = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 'key+value';

	const keys = Object.keys(headers[MAP]).sort();
	return keys.map(kind === 'key' ? function (k) {
		return k.toLowerCase();
	} : kind === 'value' ? function (k) {
		return headers[MAP][k].join(', ');
	} : function (k) {
		return [k.toLowerCase(), headers[MAP][k].join(', ')];
	});
}

const INTERNAL = Symbol('internal');

function createHeadersIterator(target, kind) {
	const iterator = Object.create(HeadersIteratorPrototype);
	iterator[INTERNAL] = {
		target,
		kind,
		index: 0
	};
	return iterator;
}

const HeadersIteratorPrototype = Object.setPrototypeOf({
	next() {
		// istanbul ignore if
		if (!this || Object.getPrototypeOf(this) !== HeadersIteratorPrototype) {
			throw new TypeError('Value of `this` is not a HeadersIterator');
		}

		var _INTERNAL = this[INTERNAL];
		const target = _INTERNAL.target,
		      kind = _INTERNAL.kind,
		      index = _INTERNAL.index;

		const values = getHeaders(target, kind);
		const len = values.length;
		if (index >= len) {
			return {
				value: undefined,
				done: true
			};
		}

		this[INTERNAL].index = index + 1;

		return {
			value: values[index],
			done: false
		};
	}
}, Object.getPrototypeOf(Object.getPrototypeOf([][Symbol.iterator]())));

Object.defineProperty(HeadersIteratorPrototype, Symbol.toStringTag, {
	value: 'HeadersIterator',
	writable: false,
	enumerable: false,
	configurable: true
});

/**
 * Export the Headers object in a form that Node.js can consume.
 *
 * @param   Headers  headers
 * @return  Object
 */
function exportNodeCompatibleHeaders(headers) {
	const obj = Object.assign({ __proto__: null }, headers[MAP]);

	// http.request() only supports string as Host header. This hack makes
	// specifying custom Host header possible.
	const hostHeaderKey = find(headers[MAP], 'Host');
	if (hostHeaderKey !== undefined) {
		obj[hostHeaderKey] = obj[hostHeaderKey][0];
	}

	return obj;
}

/**
 * Create a Headers object from an object of headers, ignoring those that do
 * not conform to HTTP grammar productions.
 *
 * @param   Object  obj  Object of headers
 * @return  Headers
 */
function createHeadersLenient(obj) {
	const headers = new Headers();
	for (const name of Object.keys(obj)) {
		if (invalidTokenRegex.test(name)) {
			continue;
		}
		if (Array.isArray(obj[name])) {
			for (const val of obj[name]) {
				if (invalidHeaderCharRegex.test(val)) {
					continue;
				}
				if (headers[MAP][name] === undefined) {
					headers[MAP][name] = [val];
				} else {
					headers[MAP][name].push(val);
				}
			}
		} else if (!invalidHeaderCharRegex.test(obj[name])) {
			headers[MAP][name] = [obj[name]];
		}
	}
	return headers;
}

/**
 * response.js
 *
 * Response class provides content decoding
 */

var _require$1 = __webpack_require__(22);

const STATUS_CODES = _require$1.STATUS_CODES;


const INTERNALS$1 = Symbol('Response internals');

/**
 * Response class
 *
 * @param   Stream  body  Readable stream
 * @param   Object  opts  Response options
 * @return  Void
 */
class Response {
	constructor() {
		let body = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : null;
		let opts = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

		Body.call(this, body, opts);

		const status = opts.status || 200;

		this[INTERNALS$1] = {
			url: opts.url,
			status,
			statusText: opts.statusText || STATUS_CODES[status],
			headers: new Headers(opts.headers)
		};
	}

	get url() {
		return this[INTERNALS$1].url;
	}

	get status() {
		return this[INTERNALS$1].status;
	}

	/**
  * Convenience property representing if the request ended normally
  */
	get ok() {
		return this[INTERNALS$1].status >= 200 && this[INTERNALS$1].status < 300;
	}

	get statusText() {
		return this[INTERNALS$1].statusText;
	}

	get headers() {
		return this[INTERNALS$1].headers;
	}

	/**
  * Clone this response
  *
  * @return  Response
  */
	clone() {
		return new Response(clone(this), {
			url: this.url,
			status: this.status,
			statusText: this.statusText,
			headers: this.headers,
			ok: this.ok
		});
	}
}

Body.mixIn(Response.prototype);

Object.defineProperties(Response.prototype, {
	url: { enumerable: true },
	status: { enumerable: true },
	ok: { enumerable: true },
	statusText: { enumerable: true },
	headers: { enumerable: true },
	clone: { enumerable: true }
});

Object.defineProperty(Response.prototype, Symbol.toStringTag, {
	value: 'Response',
	writable: false,
	enumerable: false,
	configurable: true
});

/**
 * request.js
 *
 * Request class contains server only options
 *
 * All spec algorithm step numbers are based on https://fetch.spec.whatwg.org/commit-snapshots/ae716822cb3a61843226cd090eefc6589446c1d2/.
 */

var _require$2 = __webpack_require__(23);

const format_url = _require$2.format;
const parse_url = _require$2.parse;


const INTERNALS$2 = Symbol('Request internals');

/**
 * Check if a value is an instance of Request.
 *
 * @param   Mixed   input
 * @return  Boolean
 */
function isRequest(input) {
	return typeof input === 'object' && typeof input[INTERNALS$2] === 'object';
}

/**
 * Request class
 *
 * @param   Mixed   input  Url or Request instance
 * @param   Object  init   Custom options
 * @return  Void
 */
class Request {
	constructor(input) {
		let init = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

		let parsedURL;

		// normalize input
		if (!isRequest(input)) {
			if (input && input.href) {
				// in order to support Node.js' Url objects; though WHATWG's URL objects
				// will fall into this branch also (since their `toString()` will return
				// `href` property anyway)
				parsedURL = parse_url(input.href);
			} else {
				// coerce input to a string before attempting to parse
				parsedURL = parse_url(`${input}`);
			}
			input = {};
		} else {
			parsedURL = parse_url(input.url);
		}

		let method = init.method || input.method || 'GET';
		method = method.toUpperCase();

		if ((init.body != null || isRequest(input) && input.body !== null) && (method === 'GET' || method === 'HEAD')) {
			throw new TypeError('Request with GET/HEAD method cannot have body');
		}

		let inputBody = init.body != null ? init.body : isRequest(input) && input.body !== null ? clone(input) : null;

		Body.call(this, inputBody, {
			timeout: init.timeout || input.timeout || 0,
			size: init.size || input.size || 0
		});

		const headers = new Headers(init.headers || input.headers || {});

		if (init.body != null) {
			const contentType = extractContentType(this);
			if (contentType !== null && !headers.has('Content-Type')) {
				headers.append('Content-Type', contentType);
			}
		}

		this[INTERNALS$2] = {
			method,
			redirect: init.redirect || input.redirect || 'follow',
			headers,
			parsedURL
		};

		// node-fetch-only options
		this.follow = init.follow !== undefined ? init.follow : input.follow !== undefined ? input.follow : 20;
		this.compress = init.compress !== undefined ? init.compress : input.compress !== undefined ? input.compress : true;
		this.counter = init.counter || input.counter || 0;
		this.agent = init.agent || input.agent;
	}

	get method() {
		return this[INTERNALS$2].method;
	}

	get url() {
		return format_url(this[INTERNALS$2].parsedURL);
	}

	get headers() {
		return this[INTERNALS$2].headers;
	}

	get redirect() {
		return this[INTERNALS$2].redirect;
	}

	/**
  * Clone this request
  *
  * @return  Request
  */
	clone() {
		return new Request(this);
	}
}

Body.mixIn(Request.prototype);

Object.defineProperty(Request.prototype, Symbol.toStringTag, {
	value: 'Request',
	writable: false,
	enumerable: false,
	configurable: true
});

Object.defineProperties(Request.prototype, {
	method: { enumerable: true },
	url: { enumerable: true },
	headers: { enumerable: true },
	redirect: { enumerable: true },
	clone: { enumerable: true }
});

/**
 * Convert a Request to Node.js http request options.
 *
 * @param   Request  A Request instance
 * @return  Object   The options object to be passed to http.request
 */
function getNodeRequestOptions(request) {
	const parsedURL = request[INTERNALS$2].parsedURL;
	const headers = new Headers(request[INTERNALS$2].headers);

	// fetch step 1.3
	if (!headers.has('Accept')) {
		headers.set('Accept', '*/*');
	}

	// Basic fetch
	if (!parsedURL.protocol || !parsedURL.hostname) {
		throw new TypeError('Only absolute URLs are supported');
	}

	if (!/^https?:$/.test(parsedURL.protocol)) {
		throw new TypeError('Only HTTP(S) protocols are supported');
	}

	// HTTP-network-or-cache fetch steps 2.4-2.7
	let contentLengthValue = null;
	if (request.body == null && /^(POST|PUT)$/i.test(request.method)) {
		contentLengthValue = '0';
	}
	if (request.body != null) {
		const totalBytes = getTotalBytes(request);
		if (typeof totalBytes === 'number') {
			contentLengthValue = String(totalBytes);
		}
	}
	if (contentLengthValue) {
		headers.set('Content-Length', contentLengthValue);
	}

	// HTTP-network-or-cache fetch step 2.11
	if (!headers.has('User-Agent')) {
		headers.set('User-Agent', 'node-fetch/1.0 (+https://github.com/bitinn/node-fetch)');
	}

	// HTTP-network-or-cache fetch step 2.15
	if (request.compress) {
		headers.set('Accept-Encoding', 'gzip,deflate');
	}
	if (!headers.has('Connection') && !request.agent) {
		headers.set('Connection', 'close');
	}

	// HTTP-network fetch step 4.2
	// chunked encoding is handled by Node.js

	return Object.assign({}, parsedURL, {
		method: request.method,
		headers: exportNodeCompatibleHeaders(headers),
		agent: request.agent
	});
}

/**
 * index.js
 *
 * a request API compatible with window.fetch
 *
 * All spec algorithm step numbers are based on https://fetch.spec.whatwg.org/commit-snapshots/ae716822cb3a61843226cd090eefc6589446c1d2/.
 */

const http = __webpack_require__(22);
const https = __webpack_require__(59);

var _require$3 = __webpack_require__(6);

const PassThrough$1 = _require$3.PassThrough;

var _require2 = __webpack_require__(23);

const resolve_url = _require2.resolve;

const zlib = __webpack_require__(60);

/**
 * Fetch function
 *
 * @param   Mixed    url   Absolute url or Request instance
 * @param   Object   opts  Fetch options
 * @return  Promise
 */
function fetch(url, opts) {

	// allow custom promise
	if (!fetch.Promise) {
		throw new Error('native promise missing, set fetch.Promise to your favorite alternative');
	}

	Body.Promise = fetch.Promise;

	// wrap http.request into fetch
	return new fetch.Promise(function (resolve, reject) {
		// build request object
		const request = new Request(url, opts);
		const options = getNodeRequestOptions(request);

		const send = (options.protocol === 'https:' ? https : http).request;

		// send request
		const req = send(options);
		let reqTimeout;

		function finalize() {
			req.abort();
			clearTimeout(reqTimeout);
		}

		if (request.timeout) {
			req.once('socket', function (socket) {
				reqTimeout = setTimeout(function () {
					reject(new FetchError(`network timeout at: ${request.url}`, 'request-timeout'));
					finalize();
				}, request.timeout);
			});
		}

		req.on('error', function (err) {
			reject(new FetchError(`request to ${request.url} failed, reason: ${err.message}`, 'system', err));
			finalize();
		});

		req.on('response', function (res) {
			clearTimeout(reqTimeout);

			const headers = createHeadersLenient(res.headers);

			// HTTP fetch step 5
			if (fetch.isRedirect(res.statusCode)) {
				// HTTP fetch step 5.2
				const location = headers.get('Location');

				// HTTP fetch step 5.3
				const locationURL = location === null ? null : resolve_url(request.url, location);

				// HTTP fetch step 5.5
				switch (request.redirect) {
					case 'error':
						reject(new FetchError(`redirect mode is set to error: ${request.url}`, 'no-redirect'));
						finalize();
						return;
					case 'manual':
						// node-fetch-specific step: make manual redirect a bit easier to use by setting the Location header value to the resolved URL.
						if (locationURL !== null) {
							headers.set('Location', locationURL);
						}
						break;
					case 'follow':
						// HTTP-redirect fetch step 2
						if (locationURL === null) {
							break;
						}

						// HTTP-redirect fetch step 5
						if (request.counter >= request.follow) {
							reject(new FetchError(`maximum redirect reached at: ${request.url}`, 'max-redirect'));
							finalize();
							return;
						}

						// HTTP-redirect fetch step 6 (counter increment)
						// Create a new Request object.
						const requestOpts = {
							headers: new Headers(request.headers),
							follow: request.follow,
							counter: request.counter + 1,
							agent: request.agent,
							compress: request.compress,
							method: request.method,
							body: request.body
						};

						// HTTP-redirect fetch step 9
						if (res.statusCode !== 303 && request.body && getTotalBytes(request) === null) {
							reject(new FetchError('Cannot follow redirect with body being a readable stream', 'unsupported-redirect'));
							finalize();
							return;
						}

						// HTTP-redirect fetch step 11
						if (res.statusCode === 303 || (res.statusCode === 301 || res.statusCode === 302) && request.method === 'POST') {
							requestOpts.method = 'GET';
							requestOpts.body = undefined;
							requestOpts.headers.delete('content-length');
						}

						// HTTP-redirect fetch step 15
						resolve(fetch(new Request(locationURL, requestOpts)));
						finalize();
						return;
				}
			}

			// prepare response
			let body = res.pipe(new PassThrough$1());
			const response_options = {
				url: request.url,
				status: res.statusCode,
				statusText: res.statusMessage,
				headers: headers,
				size: request.size,
				timeout: request.timeout
			};

			// HTTP-network fetch step 12.1.1.3
			const codings = headers.get('Content-Encoding');

			// HTTP-network fetch step 12.1.1.4: handle content codings

			// in following scenarios we ignore compression support
			// 1. compression support is disabled
			// 2. HEAD request
			// 3. no Content-Encoding header
			// 4. no content response (204)
			// 5. content not modified response (304)
			if (!request.compress || request.method === 'HEAD' || codings === null || res.statusCode === 204 || res.statusCode === 304) {
				resolve(new Response(body, response_options));
				return;
			}

			// For Node v6+
			// Be less strict when decoding compressed responses, since sometimes
			// servers send slightly invalid responses that are still accepted
			// by common browsers.
			// Always using Z_SYNC_FLUSH is what cURL does.
			const zlibOptions = {
				flush: zlib.Z_SYNC_FLUSH,
				finishFlush: zlib.Z_SYNC_FLUSH
			};

			// for gzip
			if (codings == 'gzip' || codings == 'x-gzip') {
				body = body.pipe(zlib.createGunzip(zlibOptions));
				resolve(new Response(body, response_options));
				return;
			}

			// for deflate
			if (codings == 'deflate' || codings == 'x-deflate') {
				// handle the infamous raw deflate response from old servers
				// a hack for old IIS and Apache servers
				const raw = res.pipe(new PassThrough$1());
				raw.once('data', function (chunk) {
					// see http://stackoverflow.com/questions/37519828
					if ((chunk[0] & 0x0F) === 0x08) {
						body = body.pipe(zlib.createInflate());
					} else {
						body = body.pipe(zlib.createInflateRaw());
					}
					resolve(new Response(body, response_options));
				});
				return;
			}

			// otherwise, use response as-is
			resolve(new Response(body, response_options));
		});

		writeToStream(req, request);
	});
}

/**
 * Redirect code matching
 *
 * @param   Number   code  Status code
 * @return  Boolean
 */
fetch.isRedirect = function (code) {
	return code === 301 || code === 302 || code === 303 || code === 307 || code === 308;
};

// Needed for TypeScript.
fetch.default = fetch;

// expose Promise
fetch.Promise = global.Promise;

/* harmony default export */ __webpack_exports__["default"] = (fetch);



/***/ }),
/* 59 */
/***/ (function(module, exports) {

module.exports = require("https");

/***/ }),
/* 60 */
/***/ (function(module, exports) {

module.exports = require("zlib");

/***/ }),
/* 61 */
/***/ (function(module, exports) {

module.exports = function (args, opts) {
    if (!opts) opts = {};
    
    var flags = { bools : {}, strings : {}, unknownFn: null };

    if (typeof opts['unknown'] === 'function') {
        flags.unknownFn = opts['unknown'];
    }

    if (typeof opts['boolean'] === 'boolean' && opts['boolean']) {
      flags.allBools = true;
    } else {
      [].concat(opts['boolean']).filter(Boolean).forEach(function (key) {
          flags.bools[key] = true;
      });
    }
    
    var aliases = {};
    Object.keys(opts.alias || {}).forEach(function (key) {
        aliases[key] = [].concat(opts.alias[key]);
        aliases[key].forEach(function (x) {
            aliases[x] = [key].concat(aliases[key].filter(function (y) {
                return x !== y;
            }));
        });
    });

    [].concat(opts.string).filter(Boolean).forEach(function (key) {
        flags.strings[key] = true;
        if (aliases[key]) {
            flags.strings[aliases[key]] = true;
        }
     });

    var defaults = opts['default'] || {};
    
    var argv = { _ : [] };
    Object.keys(flags.bools).forEach(function (key) {
        setArg(key, defaults[key] === undefined ? false : defaults[key]);
    });
    
    var notFlags = [];

    if (args.indexOf('--') !== -1) {
        notFlags = args.slice(args.indexOf('--')+1);
        args = args.slice(0, args.indexOf('--'));
    }

    function argDefined(key, arg) {
        return (flags.allBools && /^--[^=]+$/.test(arg)) ||
            flags.strings[key] || flags.bools[key] || aliases[key];
    }

    function setArg (key, val, arg) {
        if (arg && flags.unknownFn && !argDefined(key, arg)) {
            if (flags.unknownFn(arg) === false) return;
        }

        var value = !flags.strings[key] && isNumber(val)
            ? Number(val) : val
        ;
        setKey(argv, key.split('.'), value);
        
        (aliases[key] || []).forEach(function (x) {
            setKey(argv, x.split('.'), value);
        });
    }

    function setKey (obj, keys, value) {
        var o = obj;
        keys.slice(0,-1).forEach(function (key) {
            if (o[key] === undefined) o[key] = {};
            o = o[key];
        });

        var key = keys[keys.length - 1];
        if (o[key] === undefined || flags.bools[key] || typeof o[key] === 'boolean') {
            o[key] = value;
        }
        else if (Array.isArray(o[key])) {
            o[key].push(value);
        }
        else {
            o[key] = [ o[key], value ];
        }
    }
    
    function aliasIsBoolean(key) {
      return aliases[key].some(function (x) {
          return flags.bools[x];
      });
    }

    for (var i = 0; i < args.length; i++) {
        var arg = args[i];
        
        if (/^--.+=/.test(arg)) {
            // Using [\s\S] instead of . because js doesn't support the
            // 'dotall' regex modifier. See:
            // http://stackoverflow.com/a/1068308/13216
            var m = arg.match(/^--([^=]+)=([\s\S]*)$/);
            var key = m[1];
            var value = m[2];
            if (flags.bools[key]) {
                value = value !== 'false';
            }
            setArg(key, value, arg);
        }
        else if (/^--no-.+/.test(arg)) {
            var key = arg.match(/^--no-(.+)/)[1];
            setArg(key, false, arg);
        }
        else if (/^--.+/.test(arg)) {
            var key = arg.match(/^--(.+)/)[1];
            var next = args[i + 1];
            if (next !== undefined && !/^-/.test(next)
            && !flags.bools[key]
            && !flags.allBools
            && (aliases[key] ? !aliasIsBoolean(key) : true)) {
                setArg(key, next, arg);
                i++;
            }
            else if (/^(true|false)$/.test(next)) {
                setArg(key, next === 'true', arg);
                i++;
            }
            else {
                setArg(key, flags.strings[key] ? '' : true, arg);
            }
        }
        else if (/^-[^-]+/.test(arg)) {
            var letters = arg.slice(1,-1).split('');
            
            var broken = false;
            for (var j = 0; j < letters.length; j++) {
                var next = arg.slice(j+2);
                
                if (next === '-') {
                    setArg(letters[j], next, arg)
                    continue;
                }
                
                if (/[A-Za-z]/.test(letters[j]) && /=/.test(next)) {
                    setArg(letters[j], next.split('=')[1], arg);
                    broken = true;
                    break;
                }
                
                if (/[A-Za-z]/.test(letters[j])
                && /-?\d+(\.\d*)?(e-?\d+)?$/.test(next)) {
                    setArg(letters[j], next, arg);
                    broken = true;
                    break;
                }
                
                if (letters[j+1] && letters[j+1].match(/\W/)) {
                    setArg(letters[j], arg.slice(j+2), arg);
                    broken = true;
                    break;
                }
                else {
                    setArg(letters[j], flags.strings[letters[j]] ? '' : true, arg);
                }
            }
            
            var key = arg.slice(-1)[0];
            if (!broken && key !== '-') {
                if (args[i+1] && !/^(-|--)[^-]/.test(args[i+1])
                && !flags.bools[key]
                && (aliases[key] ? !aliasIsBoolean(key) : true)) {
                    setArg(key, args[i+1], arg);
                    i++;
                }
                else if (args[i+1] && /true|false/.test(args[i+1])) {
                    setArg(key, args[i+1] === 'true', arg);
                    i++;
                }
                else {
                    setArg(key, flags.strings[key] ? '' : true, arg);
                }
            }
        }
        else {
            if (!flags.unknownFn || flags.unknownFn(arg) !== false) {
                argv._.push(
                    flags.strings['_'] || !isNumber(arg) ? arg : Number(arg)
                );
            }
            if (opts.stopEarly) {
                argv._.push.apply(argv._, args.slice(i + 1));
                break;
            }
        }
    }
    
    Object.keys(defaults).forEach(function (key) {
        if (!hasKey(argv, key.split('.'))) {
            setKey(argv, key.split('.'), defaults[key]);
            
            (aliases[key] || []).forEach(function (x) {
                setKey(argv, x.split('.'), defaults[key]);
            });
        }
    });
    
    if (opts['--']) {
        argv['--'] = new Array();
        notFlags.forEach(function(key) {
            argv['--'].push(key);
        });
    }
    else {
        notFlags.forEach(function(key) {
            argv._.push(key);
        });
    }

    return argv;
};

function hasKey (obj, keys) {
    var o = obj;
    keys.slice(0,-1).forEach(function (key) {
        o = (o[key] || {});
    });

    var key = keys[keys.length - 1];
    return key in o;
}

function isNumber (x) {
    if (typeof x === 'number') return true;
    if (/^0x[0-9a-f]+$/i.test(x)) return true;
    return /^[-+]?(?:\d+(?:\.\d*)?|\.\d+)(e[-+]?\d+)?$/.test(x);
}



/***/ }),
/* 62 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var child_process_1 = __webpack_require__(63);
var fs = __webpack_require__(13);
var globalInstallPath = __dirname + "/../node_modules/.bin/elm-format";
var localInstallPath = __dirname + "/../../.bin/elm-format";
exports.writeFile = function (path, value) {
    var elmFormatPath = findElmFormatPath();
    if (elmFormatPath) {
        writeWithElmFormat(path, value, elmFormatPath);
    }
    else {
        writeWithoutFormatting(path, value);
    }
};
var writeWithElmFormat = function (path, value, elmFormatPath) {
    var elmFormat = child_process_1.spawn(elmFormatPath, ['--stdin', '--output', path], {
        shell: true
    });
    elmFormat.stdin.write(value);
    elmFormat.stdin.end();
    elmFormat.stdout.on('data', function (data) {
        console.log(data.toString());
    });
    elmFormat.stderr.on('data', function (data) {
        console.log(data.toString());
    });
    elmFormat.on('close', function (code) {
        if (code !== 0) {
            console.log("elm-format process exited with code " + code + ".\nWas attempting to write to path " + path + " with contents:\n" + value);
            process.exit(code);
        }
    });
};
var writeWithoutFormatting = function (path, value) {
    fs.writeFileSync(path, value);
};
var findElmFormatPath = function () {
    if (fs.existsSync(globalInstallPath)) {
        return globalInstallPath;
    }
    else if (fs.existsSync(localInstallPath)) {
        return localInstallPath;
    }
    else {
        return null;
    }
};


/***/ }),
/* 63 */
/***/ (function(module, exports) {

module.exports = require("child_process");

/***/ }),
/* 64 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.introspectionQuery = "query IntrospectionQuery($includeDeprecated: Boolean!) {\n    __schema {\n      queryType {\n        name\n      }\n      mutationType {\n        name\n      }\n      subscriptionType {\n        name\n      }\n      types {\n        ...FullType\n      }\n    }\n  }\n\n  fragment FullType on __Type {\n    kind\n    name\n    description\n    fields(includeDeprecated: $includeDeprecated) {\n      name\n      description\n      args {\n        ...InputValue\n      }\n      type {\n        ...TypeRef\n      }\n      isDeprecated\n      deprecationReason\n    }\n    inputFields {\n      ...InputValue\n    }\n    interfaces {\n      ...TypeRef\n    }\n    enumValues(includeDeprecated: $includeDeprecated) {\n      name\n      description\n      isDeprecated\n      deprecationReason\n    }\n    possibleTypes {\n      ...TypeRef\n    }\n  }\n\n  fragment InputValue on __InputValue {\n    name\n    description\n    type { ...TypeRef }\n    defaultValue\n  }\n\n  fragment TypeRef on __Type {\n    kind\n    name\n    ofType {\n      kind\n      name\n      ofType {\n        kind\n        name\n        ofType {\n          kind\n          name\n          ofType {\n            kind\n            name\n            ofType {\n              kind\n              name\n              ofType {\n                kind\n                name\n                ofType {\n                  kind\n                  name\n                }\n              }\n            }\n          }\n        }\n      }\n    }\n  }";


/***/ }),
/* 65 */
/***/ (function(module, exports, __webpack_require__) {

// Copyright Joyent, Inc. and other Node contributors.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
// NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.

var pathModule = __webpack_require__(0);
var isWindows = process.platform === 'win32';
var fs = __webpack_require__(4);

// JavaScript implementation of realpath, ported from node pre-v6

var DEBUG = process.env.NODE_DEBUG && /fs/.test(process.env.NODE_DEBUG);

function rethrow() {
  // Only enable in debug mode. A backtrace uses ~1000 bytes of heap space and
  // is fairly slow to generate.
  var callback;
  if (DEBUG) {
    var backtrace = new Error;
    callback = debugCallback;
  } else
    callback = missingCallback;

  return callback;

  function debugCallback(err) {
    if (err) {
      backtrace.message = err.message;
      err = backtrace;
      missingCallback(err);
    }
  }

  function missingCallback(err) {
    if (err) {
      if (process.throwDeprecation)
        throw err;  // Forgot a callback but don't know where? Use NODE_DEBUG=fs
      else if (!process.noDeprecation) {
        var msg = 'fs: missing callback ' + (err.stack || err.message);
        if (process.traceDeprecation)
          console.trace(msg);
        else
          console.error(msg);
      }
    }
  }
}

function maybeCallback(cb) {
  return typeof cb === 'function' ? cb : rethrow();
}

var normalize = pathModule.normalize;

// Regexp that finds the next partion of a (partial) path
// result is [base_with_slash, base], e.g. ['somedir/', 'somedir']
if (isWindows) {
  var nextPartRe = /(.*?)(?:[\/\\]+|$)/g;
} else {
  var nextPartRe = /(.*?)(?:[\/]+|$)/g;
}

// Regex to find the device root, including trailing slash. E.g. 'c:\\'.
if (isWindows) {
  var splitRootRe = /^(?:[a-zA-Z]:|[\\\/]{2}[^\\\/]+[\\\/][^\\\/]+)?[\\\/]*/;
} else {
  var splitRootRe = /^[\/]*/;
}

exports.realpathSync = function realpathSync(p, cache) {
  // make p is absolute
  p = pathModule.resolve(p);

  if (cache && Object.prototype.hasOwnProperty.call(cache, p)) {
    return cache[p];
  }

  var original = p,
      seenLinks = {},
      knownHard = {};

  // current character position in p
  var pos;
  // the partial path so far, including a trailing slash if any
  var current;
  // the partial path without a trailing slash (except when pointing at a root)
  var base;
  // the partial path scanned in the previous round, with slash
  var previous;

  start();

  function start() {
    // Skip over roots
    var m = splitRootRe.exec(p);
    pos = m[0].length;
    current = m[0];
    base = m[0];
    previous = '';

    // On windows, check that the root exists. On unix there is no need.
    if (isWindows && !knownHard[base]) {
      fs.lstatSync(base);
      knownHard[base] = true;
    }
  }

  // walk down the path, swapping out linked pathparts for their real
  // values
  // NB: p.length changes.
  while (pos < p.length) {
    // find the next part
    nextPartRe.lastIndex = pos;
    var result = nextPartRe.exec(p);
    previous = current;
    current += result[0];
    base = previous + result[1];
    pos = nextPartRe.lastIndex;

    // continue if not a symlink
    if (knownHard[base] || (cache && cache[base] === base)) {
      continue;
    }

    var resolvedLink;
    if (cache && Object.prototype.hasOwnProperty.call(cache, base)) {
      // some known symbolic link.  no need to stat again.
      resolvedLink = cache[base];
    } else {
      var stat = fs.lstatSync(base);
      if (!stat.isSymbolicLink()) {
        knownHard[base] = true;
        if (cache) cache[base] = base;
        continue;
      }

      // read the link if it wasn't read before
      // dev/ino always return 0 on windows, so skip the check.
      var linkTarget = null;
      if (!isWindows) {
        var id = stat.dev.toString(32) + ':' + stat.ino.toString(32);
        if (seenLinks.hasOwnProperty(id)) {
          linkTarget = seenLinks[id];
        }
      }
      if (linkTarget === null) {
        fs.statSync(base);
        linkTarget = fs.readlinkSync(base);
      }
      resolvedLink = pathModule.resolve(previous, linkTarget);
      // track this, if given a cache.
      if (cache) cache[base] = resolvedLink;
      if (!isWindows) seenLinks[id] = linkTarget;
    }

    // resolve the link, then start over
    p = pathModule.resolve(resolvedLink, p.slice(pos));
    start();
  }

  if (cache) cache[original] = p;

  return p;
};


exports.realpath = function realpath(p, cache, cb) {
  if (typeof cb !== 'function') {
    cb = maybeCallback(cache);
    cache = null;
  }

  // make p is absolute
  p = pathModule.resolve(p);

  if (cache && Object.prototype.hasOwnProperty.call(cache, p)) {
    return process.nextTick(cb.bind(null, null, cache[p]));
  }

  var original = p,
      seenLinks = {},
      knownHard = {};

  // current character position in p
  var pos;
  // the partial path so far, including a trailing slash if any
  var current;
  // the partial path without a trailing slash (except when pointing at a root)
  var base;
  // the partial path scanned in the previous round, with slash
  var previous;

  start();

  function start() {
    // Skip over roots
    var m = splitRootRe.exec(p);
    pos = m[0].length;
    current = m[0];
    base = m[0];
    previous = '';

    // On windows, check that the root exists. On unix there is no need.
    if (isWindows && !knownHard[base]) {
      fs.lstat(base, function(err) {
        if (err) return cb(err);
        knownHard[base] = true;
        LOOP();
      });
    } else {
      process.nextTick(LOOP);
    }
  }

  // walk down the path, swapping out linked pathparts for their real
  // values
  function LOOP() {
    // stop if scanned past end of path
    if (pos >= p.length) {
      if (cache) cache[original] = p;
      return cb(null, p);
    }

    // find the next part
    nextPartRe.lastIndex = pos;
    var result = nextPartRe.exec(p);
    previous = current;
    current += result[0];
    base = previous + result[1];
    pos = nextPartRe.lastIndex;

    // continue if not a symlink
    if (knownHard[base] || (cache && cache[base] === base)) {
      return process.nextTick(LOOP);
    }

    if (cache && Object.prototype.hasOwnProperty.call(cache, base)) {
      // known symbolic link.  no need to stat again.
      return gotResolvedLink(cache[base]);
    }

    return fs.lstat(base, gotStat);
  }

  function gotStat(err, stat) {
    if (err) return cb(err);

    // if not a symlink, skip to the next path part
    if (!stat.isSymbolicLink()) {
      knownHard[base] = true;
      if (cache) cache[base] = base;
      return process.nextTick(LOOP);
    }

    // stat & read the link if not read before
    // call gotTarget as soon as the link target is known
    // dev/ino always return 0 on windows, so skip the check.
    if (!isWindows) {
      var id = stat.dev.toString(32) + ':' + stat.ino.toString(32);
      if (seenLinks.hasOwnProperty(id)) {
        return gotTarget(null, seenLinks[id], base);
      }
    }
    fs.stat(base, function(err) {
      if (err) return cb(err);

      fs.readlink(base, function(err, target) {
        if (!isWindows) seenLinks[id] = target;
        gotTarget(err, target);
      });
    });
  }

  function gotTarget(err, target, base) {
    if (err) return cb(err);

    var resolvedLink = pathModule.resolve(previous, target);
    if (cache) cache[base] = resolvedLink;
    gotResolvedLink(resolvedLink);
  }

  function gotResolvedLink(resolvedLink) {
    // resolve the link, then start over
    p = pathModule.resolve(resolvedLink, p.slice(pos));
    start();
  }
};


/***/ }),
/* 66 */
/***/ (function(module, exports, __webpack_require__) {

var concatMap = __webpack_require__(67);
var balanced = __webpack_require__(68);

module.exports = expandTop;

var escSlash = '\0SLASH'+Math.random()+'\0';
var escOpen = '\0OPEN'+Math.random()+'\0';
var escClose = '\0CLOSE'+Math.random()+'\0';
var escComma = '\0COMMA'+Math.random()+'\0';
var escPeriod = '\0PERIOD'+Math.random()+'\0';

function numeric(str) {
  return parseInt(str, 10) == str
    ? parseInt(str, 10)
    : str.charCodeAt(0);
}

function escapeBraces(str) {
  return str.split('\\\\').join(escSlash)
            .split('\\{').join(escOpen)
            .split('\\}').join(escClose)
            .split('\\,').join(escComma)
            .split('\\.').join(escPeriod);
}

function unescapeBraces(str) {
  return str.split(escSlash).join('\\')
            .split(escOpen).join('{')
            .split(escClose).join('}')
            .split(escComma).join(',')
            .split(escPeriod).join('.');
}


// Basically just str.split(","), but handling cases
// where we have nested braced sections, which should be
// treated as individual members, like {a,{b,c},d}
function parseCommaParts(str) {
  if (!str)
    return [''];

  var parts = [];
  var m = balanced('{', '}', str);

  if (!m)
    return str.split(',');

  var pre = m.pre;
  var body = m.body;
  var post = m.post;
  var p = pre.split(',');

  p[p.length-1] += '{' + body + '}';
  var postParts = parseCommaParts(post);
  if (post.length) {
    p[p.length-1] += postParts.shift();
    p.push.apply(p, postParts);
  }

  parts.push.apply(parts, p);

  return parts;
}

function expandTop(str) {
  if (!str)
    return [];

  // I don't know why Bash 4.3 does this, but it does.
  // Anything starting with {} will have the first two bytes preserved
  // but *only* at the top level, so {},a}b will not expand to anything,
  // but a{},b}c will be expanded to [a}c,abc].
  // One could argue that this is a bug in Bash, but since the goal of
  // this module is to match Bash's rules, we escape a leading {}
  if (str.substr(0, 2) === '{}') {
    str = '\\{\\}' + str.substr(2);
  }

  return expand(escapeBraces(str), true).map(unescapeBraces);
}

function identity(e) {
  return e;
}

function embrace(str) {
  return '{' + str + '}';
}
function isPadded(el) {
  return /^-?0\d/.test(el);
}

function lte(i, y) {
  return i <= y;
}
function gte(i, y) {
  return i >= y;
}

function expand(str, isTop) {
  var expansions = [];

  var m = balanced('{', '}', str);
  if (!m || /\$$/.test(m.pre)) return [str];

  var isNumericSequence = /^-?\d+\.\.-?\d+(?:\.\.-?\d+)?$/.test(m.body);
  var isAlphaSequence = /^[a-zA-Z]\.\.[a-zA-Z](?:\.\.-?\d+)?$/.test(m.body);
  var isSequence = isNumericSequence || isAlphaSequence;
  var isOptions = m.body.indexOf(',') >= 0;
  if (!isSequence && !isOptions) {
    // {a},b}
    if (m.post.match(/,.*\}/)) {
      str = m.pre + '{' + m.body + escClose + m.post;
      return expand(str);
    }
    return [str];
  }

  var n;
  if (isSequence) {
    n = m.body.split(/\.\./);
  } else {
    n = parseCommaParts(m.body);
    if (n.length === 1) {
      // x{{a,b}}y ==> x{a}y x{b}y
      n = expand(n[0], false).map(embrace);
      if (n.length === 1) {
        var post = m.post.length
          ? expand(m.post, false)
          : [''];
        return post.map(function(p) {
          return m.pre + n[0] + p;
        });
      }
    }
  }

  // at this point, n is the parts, and we know it's not a comma set
  // with a single entry.

  // no need to expand pre, since it is guaranteed to be free of brace-sets
  var pre = m.pre;
  var post = m.post.length
    ? expand(m.post, false)
    : [''];

  var N;

  if (isSequence) {
    var x = numeric(n[0]);
    var y = numeric(n[1]);
    var width = Math.max(n[0].length, n[1].length)
    var incr = n.length == 3
      ? Math.abs(numeric(n[2]))
      : 1;
    var test = lte;
    var reverse = y < x;
    if (reverse) {
      incr *= -1;
      test = gte;
    }
    var pad = n.some(isPadded);

    N = [];

    for (var i = x; test(i, y); i += incr) {
      var c;
      if (isAlphaSequence) {
        c = String.fromCharCode(i);
        if (c === '\\')
          c = '';
      } else {
        c = String(i);
        if (pad) {
          var need = width - c.length;
          if (need > 0) {
            var z = new Array(need + 1).join('0');
            if (i < 0)
              c = '-' + z + c.slice(1);
            else
              c = z + c;
          }
        }
      }
      N.push(c);
    }
  } else {
    N = concatMap(n, function(el) { return expand(el, false) });
  }

  for (var j = 0; j < N.length; j++) {
    for (var k = 0; k < post.length; k++) {
      var expansion = pre + N[j] + post[k];
      if (!isTop || isSequence || expansion)
        expansions.push(expansion);
    }
  }

  return expansions;
}



/***/ }),
/* 67 */
/***/ (function(module, exports) {

module.exports = function (xs, fn) {
    var res = [];
    for (var i = 0; i < xs.length; i++) {
        var x = fn(xs[i], i);
        if (isArray(x)) res.push.apply(res, x);
        else res.push(x);
    }
    return res;
};

var isArray = Array.isArray || function (xs) {
    return Object.prototype.toString.call(xs) === '[object Array]';
};


/***/ }),
/* 68 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

module.exports = balanced;
function balanced(a, b, str) {
  if (a instanceof RegExp) a = maybeMatch(a, str);
  if (b instanceof RegExp) b = maybeMatch(b, str);

  var r = range(a, b, str);

  return r && {
    start: r[0],
    end: r[1],
    pre: str.slice(0, r[0]),
    body: str.slice(r[0] + a.length, r[1]),
    post: str.slice(r[1] + b.length)
  };
}

function maybeMatch(reg, str) {
  var m = str.match(reg);
  return m ? m[0] : null;
}

balanced.range = range;
function range(a, b, str) {
  var begs, beg, left, right, result;
  var ai = str.indexOf(a);
  var bi = str.indexOf(b, ai + 1);
  var i = ai;

  if (ai >= 0 && bi > 0) {
    begs = [];
    left = str.length;

    while (i >= 0 && !result) {
      if (i == ai) {
        begs.push(i);
        ai = str.indexOf(a, i + 1);
      } else if (begs.length == 1) {
        result = [ begs.pop(), bi ];
      } else {
        beg = begs.pop();
        if (beg < left) {
          left = beg;
          right = bi;
        }

        bi = str.indexOf(b, i + 1);
      }

      i = ai < bi && ai >= 0 ? ai : bi;
    }

    if (begs.length) {
      result = [ left, right ];
    }
  }

  return result;
}


/***/ }),
/* 69 */
/***/ (function(module, exports, __webpack_require__) {

try {
  var util = __webpack_require__(7);
  if (typeof util.inherits !== 'function') throw '';
  module.exports = util.inherits;
} catch (e) {
  module.exports = __webpack_require__(70);
}


/***/ }),
/* 70 */
/***/ (function(module, exports) {

if (typeof Object.create === 'function') {
  // implementation from standard node.js 'util' module
  module.exports = function inherits(ctor, superCtor) {
    ctor.super_ = superCtor
    ctor.prototype = Object.create(superCtor.prototype, {
      constructor: {
        value: ctor,
        enumerable: false,
        writable: true,
        configurable: true
      }
    });
  };
} else {
  // old school shim for old browsers
  module.exports = function inherits(ctor, superCtor) {
    ctor.super_ = superCtor
    var TempCtor = function () {}
    TempCtor.prototype = superCtor.prototype
    ctor.prototype = new TempCtor()
    ctor.prototype.constructor = ctor
  }
}


/***/ }),
/* 71 */
/***/ (function(module, exports) {

module.exports = require("events");

/***/ }),
/* 72 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = globSync
globSync.GlobSync = GlobSync

var fs = __webpack_require__(4)
var rp = __webpack_require__(25)
var minimatch = __webpack_require__(11)
var Minimatch = minimatch.Minimatch
var Glob = __webpack_require__(24).Glob
var util = __webpack_require__(7)
var path = __webpack_require__(0)
var assert = __webpack_require__(8)
var isAbsolute = __webpack_require__(12)
var common = __webpack_require__(26)
var alphasort = common.alphasort
var alphasorti = common.alphasorti
var setopts = common.setopts
var ownProp = common.ownProp
var childrenIgnored = common.childrenIgnored
var isIgnored = common.isIgnored

function globSync (pattern, options) {
  if (typeof options === 'function' || arguments.length === 3)
    throw new TypeError('callback provided to sync glob\n'+
                        'See: https://github.com/isaacs/node-glob/issues/167')

  return new GlobSync(pattern, options).found
}

function GlobSync (pattern, options) {
  if (!pattern)
    throw new Error('must provide pattern')

  if (typeof options === 'function' || arguments.length === 3)
    throw new TypeError('callback provided to sync glob\n'+
                        'See: https://github.com/isaacs/node-glob/issues/167')

  if (!(this instanceof GlobSync))
    return new GlobSync(pattern, options)

  setopts(this, pattern, options)

  if (this.noprocess)
    return this

  var n = this.minimatch.set.length
  this.matches = new Array(n)
  for (var i = 0; i < n; i ++) {
    this._process(this.minimatch.set[i], i, false)
  }
  this._finish()
}

GlobSync.prototype._finish = function () {
  assert(this instanceof GlobSync)
  if (this.realpath) {
    var self = this
    this.matches.forEach(function (matchset, index) {
      var set = self.matches[index] = Object.create(null)
      for (var p in matchset) {
        try {
          p = self._makeAbs(p)
          var real = rp.realpathSync(p, self.realpathCache)
          set[real] = true
        } catch (er) {
          if (er.syscall === 'stat')
            set[self._makeAbs(p)] = true
          else
            throw er
        }
      }
    })
  }
  common.finish(this)
}


GlobSync.prototype._process = function (pattern, index, inGlobStar) {
  assert(this instanceof GlobSync)

  // Get the first [n] parts of pattern that are all strings.
  var n = 0
  while (typeof pattern[n] === 'string') {
    n ++
  }
  // now n is the index of the first one that is *not* a string.

  // See if there's anything else
  var prefix
  switch (n) {
    // if not, then this is rather simple
    case pattern.length:
      this._processSimple(pattern.join('/'), index)
      return

    case 0:
      // pattern *starts* with some non-trivial item.
      // going to readdir(cwd), but not include the prefix in matches.
      prefix = null
      break

    default:
      // pattern has some string bits in the front.
      // whatever it starts with, whether that's 'absolute' like /foo/bar,
      // or 'relative' like '../baz'
      prefix = pattern.slice(0, n).join('/')
      break
  }

  var remain = pattern.slice(n)

  // get the list of entries.
  var read
  if (prefix === null)
    read = '.'
  else if (isAbsolute(prefix) || isAbsolute(pattern.join('/'))) {
    if (!prefix || !isAbsolute(prefix))
      prefix = '/' + prefix
    read = prefix
  } else
    read = prefix

  var abs = this._makeAbs(read)

  //if ignored, skip processing
  if (childrenIgnored(this, read))
    return

  var isGlobStar = remain[0] === minimatch.GLOBSTAR
  if (isGlobStar)
    this._processGlobStar(prefix, read, abs, remain, index, inGlobStar)
  else
    this._processReaddir(prefix, read, abs, remain, index, inGlobStar)
}


GlobSync.prototype._processReaddir = function (prefix, read, abs, remain, index, inGlobStar) {
  var entries = this._readdir(abs, inGlobStar)

  // if the abs isn't a dir, then nothing can match!
  if (!entries)
    return

  // It will only match dot entries if it starts with a dot, or if
  // dot is set.  Stuff like @(.foo|.bar) isn't allowed.
  var pn = remain[0]
  var negate = !!this.minimatch.negate
  var rawGlob = pn._glob
  var dotOk = this.dot || rawGlob.charAt(0) === '.'

  var matchedEntries = []
  for (var i = 0; i < entries.length; i++) {
    var e = entries[i]
    if (e.charAt(0) !== '.' || dotOk) {
      var m
      if (negate && !prefix) {
        m = !e.match(pn)
      } else {
        m = e.match(pn)
      }
      if (m)
        matchedEntries.push(e)
    }
  }

  var len = matchedEntries.length
  // If there are no matched entries, then nothing matches.
  if (len === 0)
    return

  // if this is the last remaining pattern bit, then no need for
  // an additional stat *unless* the user has specified mark or
  // stat explicitly.  We know they exist, since readdir returned
  // them.

  if (remain.length === 1 && !this.mark && !this.stat) {
    if (!this.matches[index])
      this.matches[index] = Object.create(null)

    for (var i = 0; i < len; i ++) {
      var e = matchedEntries[i]
      if (prefix) {
        if (prefix.slice(-1) !== '/')
          e = prefix + '/' + e
        else
          e = prefix + e
      }

      if (e.charAt(0) === '/' && !this.nomount) {
        e = path.join(this.root, e)
      }
      this._emitMatch(index, e)
    }
    // This was the last one, and no stats were needed
    return
  }

  // now test all matched entries as stand-ins for that part
  // of the pattern.
  remain.shift()
  for (var i = 0; i < len; i ++) {
    var e = matchedEntries[i]
    var newPattern
    if (prefix)
      newPattern = [prefix, e]
    else
      newPattern = [e]
    this._process(newPattern.concat(remain), index, inGlobStar)
  }
}


GlobSync.prototype._emitMatch = function (index, e) {
  if (isIgnored(this, e))
    return

  var abs = this._makeAbs(e)

  if (this.mark)
    e = this._mark(e)

  if (this.absolute) {
    e = abs
  }

  if (this.matches[index][e])
    return

  if (this.nodir) {
    var c = this.cache[abs]
    if (c === 'DIR' || Array.isArray(c))
      return
  }

  this.matches[index][e] = true

  if (this.stat)
    this._stat(e)
}


GlobSync.prototype._readdirInGlobStar = function (abs) {
  // follow all symlinked directories forever
  // just proceed as if this is a non-globstar situation
  if (this.follow)
    return this._readdir(abs, false)

  var entries
  var lstat
  var stat
  try {
    lstat = fs.lstatSync(abs)
  } catch (er) {
    if (er.code === 'ENOENT') {
      // lstat failed, doesn't exist
      return null
    }
  }

  var isSym = lstat && lstat.isSymbolicLink()
  this.symlinks[abs] = isSym

  // If it's not a symlink or a dir, then it's definitely a regular file.
  // don't bother doing a readdir in that case.
  if (!isSym && lstat && !lstat.isDirectory())
    this.cache[abs] = 'FILE'
  else
    entries = this._readdir(abs, false)

  return entries
}

GlobSync.prototype._readdir = function (abs, inGlobStar) {
  var entries

  if (inGlobStar && !ownProp(this.symlinks, abs))
    return this._readdirInGlobStar(abs)

  if (ownProp(this.cache, abs)) {
    var c = this.cache[abs]
    if (!c || c === 'FILE')
      return null

    if (Array.isArray(c))
      return c
  }

  try {
    return this._readdirEntries(abs, fs.readdirSync(abs))
  } catch (er) {
    this._readdirError(abs, er)
    return null
  }
}

GlobSync.prototype._readdirEntries = function (abs, entries) {
  // if we haven't asked to stat everything, then just
  // assume that everything in there exists, so we can avoid
  // having to stat it a second time.
  if (!this.mark && !this.stat) {
    for (var i = 0; i < entries.length; i ++) {
      var e = entries[i]
      if (abs === '/')
        e = abs + e
      else
        e = abs + '/' + e
      this.cache[e] = true
    }
  }

  this.cache[abs] = entries

  // mark and cache dir-ness
  return entries
}

GlobSync.prototype._readdirError = function (f, er) {
  // handle errors, and cache the information
  switch (er.code) {
    case 'ENOTSUP': // https://github.com/isaacs/node-glob/issues/205
    case 'ENOTDIR': // totally normal. means it *does* exist.
      var abs = this._makeAbs(f)
      this.cache[abs] = 'FILE'
      if (abs === this.cwdAbs) {
        var error = new Error(er.code + ' invalid cwd ' + this.cwd)
        error.path = this.cwd
        error.code = er.code
        throw error
      }
      break

    case 'ENOENT': // not terribly unusual
    case 'ELOOP':
    case 'ENAMETOOLONG':
    case 'UNKNOWN':
      this.cache[this._makeAbs(f)] = false
      break

    default: // some unusual error.  Treat as failure.
      this.cache[this._makeAbs(f)] = false
      if (this.strict)
        throw er
      if (!this.silent)
        console.error('glob error', er)
      break
  }
}

GlobSync.prototype._processGlobStar = function (prefix, read, abs, remain, index, inGlobStar) {

  var entries = this._readdir(abs, inGlobStar)

  // no entries means not a dir, so it can never have matches
  // foo.txt/** doesn't match foo.txt
  if (!entries)
    return

  // test without the globstar, and with every child both below
  // and replacing the globstar.
  var remainWithoutGlobStar = remain.slice(1)
  var gspref = prefix ? [ prefix ] : []
  var noGlobStar = gspref.concat(remainWithoutGlobStar)

  // the noGlobStar pattern exits the inGlobStar state
  this._process(noGlobStar, index, false)

  var len = entries.length
  var isSym = this.symlinks[abs]

  // If it's a symlink, and we're in a globstar, then stop
  if (isSym && inGlobStar)
    return

  for (var i = 0; i < len; i++) {
    var e = entries[i]
    if (e.charAt(0) === '.' && !this.dot)
      continue

    // these two cases enter the inGlobStar state
    var instead = gspref.concat(entries[i], remainWithoutGlobStar)
    this._process(instead, index, true)

    var below = gspref.concat(entries[i], remain)
    this._process(below, index, true)
  }
}

GlobSync.prototype._processSimple = function (prefix, index) {
  // XXX review this.  Shouldn't it be doing the mounting etc
  // before doing stat?  kinda weird?
  var exists = this._stat(prefix)

  if (!this.matches[index])
    this.matches[index] = Object.create(null)

  // If it doesn't exist, then just mark the lack of results
  if (!exists)
    return

  if (prefix && isAbsolute(prefix) && !this.nomount) {
    var trail = /[\/\\]$/.test(prefix)
    if (prefix.charAt(0) === '/') {
      prefix = path.join(this.root, prefix)
    } else {
      prefix = path.resolve(this.root, prefix)
      if (trail)
        prefix += '/'
    }
  }

  if (process.platform === 'win32')
    prefix = prefix.replace(/\\/g, '/')

  // Mark this as a match
  this._emitMatch(index, prefix)
}

// Returns either 'DIR', 'FILE', or false
GlobSync.prototype._stat = function (f) {
  var abs = this._makeAbs(f)
  var needDir = f.slice(-1) === '/'

  if (f.length > this.maxLength)
    return false

  if (!this.stat && ownProp(this.cache, abs)) {
    var c = this.cache[abs]

    if (Array.isArray(c))
      c = 'DIR'

    // It exists, but maybe not how we need it
    if (!needDir || c === 'DIR')
      return c

    if (needDir && c === 'FILE')
      return false

    // otherwise we have to stat, because maybe c=true
    // if we know it exists, but not what it is.
  }

  var exists
  var stat = this.statCache[abs]
  if (!stat) {
    var lstat
    try {
      lstat = fs.lstatSync(abs)
    } catch (er) {
      if (er && (er.code === 'ENOENT' || er.code === 'ENOTDIR')) {
        this.statCache[abs] = false
        return false
      }
    }

    if (lstat && lstat.isSymbolicLink()) {
      try {
        stat = fs.statSync(abs)
      } catch (er) {
        stat = lstat
      }
    } else {
      stat = lstat
    }
  }

  this.statCache[abs] = stat

  var c = true
  if (stat)
    c = stat.isDirectory() ? 'DIR' : 'FILE'

  this.cache[abs] = this.cache[abs] || c

  if (needDir && c === 'FILE')
    return false

  return c
}

GlobSync.prototype._mark = function (p) {
  return common.mark(this, p)
}

GlobSync.prototype._makeAbs = function (f) {
  return common.makeAbs(this, f)
}


/***/ }),
/* 73 */
/***/ (function(module, exports, __webpack_require__) {

var wrappy = __webpack_require__(27)
var reqs = Object.create(null)
var once = __webpack_require__(28)

module.exports = wrappy(inflight)

function inflight (key, cb) {
  if (reqs[key]) {
    reqs[key].push(cb)
    return null
  } else {
    reqs[key] = [cb]
    return makeres(key)
  }
}

function makeres (key) {
  return once(function RES () {
    var cbs = reqs[key]
    var len = cbs.length
    var args = slice(arguments)

    // XXX It's somewhat ambiguous whether a new callback added in this
    // pass should be queued for later execution if something in the
    // list of callbacks throws, or if it should just be discarded.
    // However, it's such an edge case that it hardly matters, and either
    // choice is likely as surprising as the other.
    // As it happens, we do go ahead and schedule it for later execution.
    try {
      for (var i = 0; i < len; i++) {
        cbs[i].apply(null, args)
      }
    } finally {
      if (cbs.length > len) {
        // added more in the interim.
        // de-zalgo, just in case, but don't call again.
        cbs.splice(0, len)
        process.nextTick(function () {
          RES.apply(null, args)
        })
      } else {
        delete reqs[key]
      }
    }
  })
}

function slice (args) {
  var length = args.length
  var array = []

  for (var i = 0; i < length; i++) array[i] = args[i]
  return array
}


/***/ }),
/* 74 */
/***/ (function(module, exports) {

module.exports = {"name":"@dillonkearns/elm-graphql","version":"1.0.0","scripts":{"build":"webpack","elm-nuke":"rm -rf elm-stuff && elm package install -y && cd tests && rm -rf elm-stuff && elm package install -y && cd ..","start":"cd examples && elm-live src/GithubComplex.elm --open --output=elm.js","test":"elm-test && cd generator && elm-test","gen:starwars":"npm run build && ./bin/elm-graphql https://elm-graphql.herokuapp.com --base Swapi --output examples/src","gen:normalize_test":"npm run build && cd ete_tests && ../bin/elm-graphql http://localhost:4000 --base Normalize && cd -","gen:github":"npm run build && ./bin/elm-graphql --introspection-file examples/github-schema.json --base Github --output examples/src","approve-compilation":"cd ete_tests && elm make src/NormalizeDemo.elm --output /dev/null && cd - && cd examples && elm make --output /dev/null src/Github.elm src/Starwars.elm src/GithubComplex.elm src/SimpleMutation.elm","approve":"npm run build && npm link && elm-graphql --introspection-file examples/github-schema.json --base Github --output examples/src && elm-graphql https://elm-graphql.herokuapp.com/api --base Swapi --output examples/src && elm-graphql https://elm-graphql-normalize.herokuapp.com/api --base Normalize --output ete_tests/src && echo 'Ensuring documentation is valid...' && elm make --docs=documentation.json && echo 'Confirming that examples folder is clean...' && (git diff --exit-code -- examples || (echo 'FAILURE' && echo 'examples code has changed. Commit changes to approve.' && exit 1)) && echo 'Confirming that ete_tests folder is clean...' && (git diff --exit-code -- ete_tests || (echo 'FAILURE' && echo 'ete_tests code has changed. Commit changes to approve.' && exit 1)) && npm run approve-compilation && echo 'SUCCESS'","elm-analyse":"elm-analyse --serve"},"keywords":["elm","graphql"],"repository":"https://github.com/dillonkearns/elm-graphql","author":"Dillon Kearns","license":"BSD-3-Clause","devDependencies":{"@types/fs-extra":"^5.0.0","@types/glob":"^5.0.34","@types/minimist":"^1.2.0","@types/node":"^8.5.2","@types/request":"^2.0.9","@types/webpack":"^3.8.1","elm":"^0.19.0","elm-analyse":"^0.13.3","elm-hot-loader":"0.5.4","elm-live":"^2.7.5","elm-test":"^0.19.0-beta4","elm-webpack-loader":"https://github.com/xtian/elm-webpack-loader.git#0.19","fs-extra":"^5.0.0","ts-loader":"^3.2.0","typescript":"^2.6.2","webpack":"^3.10.0"},"dependencies":{"elm-format":"^0.8.0","glob":"^7.1.2","graphql-request":"^1.4.0","minimist":"^1.2.0","request":"^2.83.0"},"bin":{"elm-graphql":"bin/elm-graphql"}}

/***/ }),
/* 75 */
/***/ (function(module, exports) {

module.exports = {"type":"package","name":"dillonkearns/elm-graphql","summary":"Type-safe GraphQL queries in Elm.","license":"BSD-3-Clause","version":"1.0.0","exposed-modules":["Graphql.Operation","Graphql.Http","Graphql.SelectionSet","Graphql.Internal.Encode","Graphql.Document","Graphql.Field","Graphql.Internal.Builder.Argument","Graphql.Internal.Builder.Object","Graphql.OptionalArgument","Graphql.Http.GraphqlError"],"elm-version":"0.19.0 <= v < 0.20.0","dependencies":{"elm/core":"1.0.0 <= v < 2.0.0","elm/http":"1.0.0 <= v < 2.0.0","elm/json":"1.0.0 <= v < 2.0.0","elm/time":"1.0.0 <= v < 2.0.0","elm/url":"1.0.0 <= v < 2.0.0","elm-community/list-extra":"8.0.0 <= v < 9.0.0","lukewestby/elm-string-interpolate":"1.0.3 <= v < 2.0.0"},"test-dependencies":{"elm/html":"1.0.0 <= v < 2.0.0","elm-explorations/test":"1.0.0 <= v < 2.0.0"}}

/***/ })
/******/ ]);