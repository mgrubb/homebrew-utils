class Apg < Formula
  desc 'Password Generator'
  homepage 'https://github.com/mgrubb/app.git'
  head 'https://github.com/mgrubb/apg.git'
  depends_on 'openssl'

  patch :p1, :DATA

  def install
    system 'make', "INSTALL_PREFIX=#{prefix}"
    system 'make', "INSTALL_PREFIX=#{prefix}", 'install'
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test apg`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system '#{bin}/program', 'do', 'something'`.
    system 'apg'
  end
end

__END__
diff --git a/Makefile b/Makefile
index c8dab03..30cb823 100644
--- a/Makefile
+++ b/Makefile
@@ -6,14 +6,14 @@ CC = gcc
 ##################################################################
 # Compilation flags
 # You should comment the line below for AIX+native cc
-FLAGS = -Wall
+FLAGS = -Wall -L/usr/local/opt/openssl/lib
 
 ##################################################################
 # Libraries
 #
 # You should comment the line below ('LIBS= -lcrypt')for QNX RTP
 # 6.1.0, OpenBSD 2.8 and above, WIN32 (+MinGW)
-LIBS = -lcrypt
+LIBS = -lcrypto
 LIBM = -lm
 # Use lines below for cygwin
 # LIBS = 
@@ -113,19 +113,19 @@ install:
 	if test -x ./apg; then \
 ./mkinstalldirs ${INSTALL_PREFIX}${APG_BIN_DIR}; \
 ./mkinstalldirs ${INSTALL_PREFIX}${APG_MAN_DIR}; \
-./install-sh -c -m 0755 -o root -g ${FIND_GROUP} ./apg ${INSTALL_PREFIX}${APG_BIN_DIR}; \
+./install-sh -c -m 0755 ./apg ${INSTALL_PREFIX}${APG_BIN_DIR}; \
 ./install-sh -c -m 0444 ./doc/man/apg.1 ${INSTALL_PREFIX}${APG_MAN_DIR}; \
 fi
 	if test -x ./apgd; then \
 ./mkinstalldirs ${INSTALL_PREFIX}${APGD_BIN_DIR}; \
 ./mkinstalldirs ${INSTALL_PREFIX}${APGD_MAN_DIR}; \
-./install-sh -c -m 0755 -o root -g ${FIND_GROUP} ./apgd ${INSTALL_PREFIX}${APGD_BIN_DIR}; \
+./install-sh -c -m 0755 ./apgd ${INSTALL_PREFIX}${APGD_BIN_DIR}; \
 ./install-sh -c -m 0444 ./doc/man/apgd.8 ${INSTALL_PREFIX}${APGD_MAN_DIR}; \
 fi
 	if test -x ./apgbfm; then \
 ./mkinstalldirs ${INSTALL_PREFIX}${APG_BIN_DIR}; \
 ./mkinstalldirs ${INSTALL_PREFIX}${APG_MAN_DIR}; \
-./install-sh -c -m 0755 -o root -g ${FIND_GROUP} ./apgbfm ${INSTALL_PREFIX}${APG_BIN_DIR}; \
+./install-sh -c -m 0755 ./apgbfm ${INSTALL_PREFIX}${APG_BIN_DIR}; \
 ./install-sh -c -m 0444 ./doc/man/apgbfm.1 ${INSTALL_PREFIX}${APG_MAN_DIR}; \
 fi
 
@@ -145,3 +145,5 @@ fi
 
 clean:
 	rm -f ${CS_PROGNAME} ${PROGNAME} ${BFM_PROGNAME} ${OBJECTS} *core*
+
+.PHONY: install
