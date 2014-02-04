version=\
(
    '1.0'
)

url=\
(
    'http://search.cpan.org/CPAN/authors/id/M/MS/MSCHWERN/ExtUtils-MakeMaker-6.56.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/IO-Tty-1.10.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/R/RG/RGIERSIG/Expect-1.21.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/M/MI/MIYAGAWA/Class-Trigger-0.14.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/K/KA/KASEI/Class-Accessor-0.34.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/Class-Data-Inheritable-0.08.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/R/RD/RDF/Clone-0.31.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/K/KA/KASEI/UNIVERSAL-moniker-0.08.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/T/TI/TIMB/DBI-1.616.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/DBIx-ContextualFetch-1.03.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/P/PE/PERRIN/Ima-DBI-0.35.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/A/AD/ADAMK/DBD-SQLite-1.31.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/Class-DBI-v3.0.17.tar.gz'
    'http://search.cpan.org/CPAN/authors/id/M/MI/MIYAGAWA/Class-DBI-SQLite-0.11.tar.gz'
)

md5=\
(
    'af7e032a1e845e4decf7672929510b98'
    '46baec86a145e57f0ec661fa412b097c'
    'a151b0dc4d1a35c73941c65b7c26da5b'
    'b0a95ebe359a3c4e768d81fc58031c83'
    '0d9640d237a13276145f7e44b4855b89'
    'fc0fe65926eb8fb932743559feb54eb9'
    '65f34e7280d7b7dfb72ab6224e5767f5'
    'e59b97ccf88f9fa68c3e5c18d7059d57'
    '799313e54a693beb635b47918458f7c4'
    '20a78432ae26b266216b7b30ff7941c3'
    'f3c5c0b1fe509556ca35f08aae91b3f5'
    '67b3575104efd606c8093bc416e3338d'
    'df59962bab98a0d31bf1d04d7270831b'
    '25e80b9d2f2d66e6fc51d487f0894802'
)

requires=\
(
    'perl/default'
    'qemu/host'
)

post_unpack()
{
    sed "s!%cfg_dir_rootfs%!$cfg_dir_rootfs!g" "$pkg_dir"/perl.in > "$pkg_build_dir"/perl &&
    chmod 0755 "$pkg_build_dir"/perl
}

target_install()
{
    export CC="$cfg_target_canonical-gcc"
    export PATH="$pkg_build_dir":$PATH
    export PERL_LIB="$cfg_dir_rootfs/usr/lib/perl5/5.10.0"
    export PERL_SITELIB="$cfg_dir_rootfs/usr/lib/perl5/site_perl/5.10.0/arm-linux-thread-multi"
    export PERL5LIB="$cfg_dir_rootfs/usr/lib/perl5/5.10.0"
    export PERL_MM_USE_DEFAULT=1
    export PERL_ARCHLIB="$cfg_dir_rootfs/usr/lib/perl5/5.10.0/arm-linux-thread-multi"
    export INST_MAN1DIR=/tmp/perl-modules
    export INST_MAN3DIR=/tmp/perl-modules
    export PREFIX="$cfg_dir_rootfs/usr"
    export INSTALLSITELIB="$PERL_SITELIB"
    export INSTALLSITEARCH="$PERL_SITELIB"
    export INSTALLARCHLIB="$PERL_SITELIB"

    n=0; while [ -n "${url[$n]}" ]; do
        pkg="$(basename "${url[$n]}" .tar.gz)"

        cd "$pkg_build_dir/../$pkg"

        "$pkg_build_dir/perl" Makefile.PL \
            PERL="$pkg_build_dir/perl" \
            FULLPERL="$pkg_build_dir/perl" \
            PERL_ARCHLIB=${PERL_ARCHLIB} \
            INST_MAN1DIR=${INST_MAN1DIR} \
            INST_MAN3DIR=${INST_MAN3DIR} \
            PREFIX=${PREFIX} \
            INSTALLSITELIB=${INSTALLSITELIB} \
            INSTALLSITEARCH=${INSTALLSITEARCH} \
            INSTALLARCHLIB=${INSTALLARCHLIB} &&

            make install UNINST=1 || return 1

            cd "$pkg_build_dir"
            let n++
    done
}
