#!/bin/sh -eu

# Installs the newest released clang that apt.llvm.org builds for this
# Ubuntu, rather than the one Ubuntu's own archive froze at its release.
# apt.llvm.org keeps one repository per LLVM major version, named
# llvm-toolchain-<codename>-<major>, each built for amd64 and arm64, plus an
# unnumbered one holding the development snapshot. The highest numbered one
# is the newest release, and is resolved here at build time so a rebuild
# picks up the next major version by itself.

apt-get update
apt-get install --yes --no-install-recommends curl ca-certificates

. /etc/os-release
readonly CODENAME="${VERSION_CODENAME}"

# apt.llvm.org gzips its directory listing whether or not it was asked to, so
# --compressed is what turns the reply back into searchable text.
readonly LLVM_MAJOR=$(curl --silent --fail --compressed "https://apt.llvm.org/${CODENAME}/dists/" \
  | grep -oE "llvm-toolchain-${CODENAME}-[0-9]+/" \
  | grep -oE '[0-9]+/$' \
  | tr -d / \
  | sort -n \
  | tail -1)

# An empty major means the listing could not be read or has changed shape,
# not that LLVM stopped publishing, so stop rather than install nothing.
if [ -z "${LLVM_MAJOR}" ]; then
  echo "Found no llvm-toolchain-${CODENAME}-<major> at apt.llvm.org" >&2
  exit 1
fi

# apt reads an ASCII-armored key directly when its name ends in .asc, so the
# key needs no gpg to dearmor it.
mkdir -p /etc/apt/keyrings
curl --silent --fail https://apt.llvm.org/llvm-snapshot.gpg.key \
  > /etc/apt/keyrings/apt.llvm.org.asc
echo "deb [signed-by=/etc/apt/keyrings/apt.llvm.org.asc] https://apt.llvm.org/${CODENAME}/ llvm-toolchain-${CODENAME}-${LLVM_MAJOR} main" \
  > /etc/apt/sources.list.d/apt.llvm.org.list

apt-get update
# libclang-rt holds the sanitizer and coverage runtimes a kata's makefile
# links against (-fsanitize=address, --coverage).
apt-get install --yes --no-install-recommends \
  "clang-${LLVM_MAJOR}" \
  "llvm-${LLVM_MAJOR}" \
  "libclang-rt-${LLVM_MAJOR}-dev" \
  gcovr

# The packages install every tool under /usr/lib/llvm-<major>/bin and name
# only some of them with a -<major> suffix in /usr/bin. Linking the whole
# directory gives a kata the unversioned names it calls: clang++, and the
# llvm-cov that gcovr runs.
ln --symbolic --force /usr/lib/llvm-"${LLVM_MAJOR}"/bin/* /usr/local/bin/

# apt's package lists are left in place: the images built on this one
# install their test frameworks with apt-get install and rely on them.

# Records the C++ this image holds, in the shape every image shares. The
# installed compiler is asked, so the version is one the image can run rather
# than one written down when someone last edited this file. -dumpversion
# prints the version alone, where --version prints a sentence around it.
readonly LANGUAGE_VERSION=$(clang++ -dumpversion)

if [ -z "${LANGUAGE_VERSION}" ]; then
  echo 'Could not read a version from clang++ -dumpversion' >&2
  exit 1
fi

cat > /versions.json <<EOF
{
  "language": {
    "name": "C++ (clang++)",
    "version": "${LANGUAGE_VERSION}"
  },
  "test_frameworks": []
}
EOF
