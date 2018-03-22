#!/usr/bin/env bash

yum install -y java-1.8.0-openjdk-devel

version=6.2.3

mkdir test && cd test
jar -xvf /usr/share/elasticsearch/plugins/x-pack/x-pack-core/x-pack-core-*.jar

echo -ne '''
package org.elasticsearch.license;

public class LicenseVerifier
{
    public static boolean verifyLicense(final License license, final byte[] encryptedPublicKeyData) {
        return true;
    }

    public static boolean verifyLicense(final License license) {
        return true;
    }
}
'''>LicenseVerifier.java

javac -cp "/usr/share/elasticsearch/lib/elasticsearch-*.jar:/usr/share/elasticsearch/lib/lucene-core-*.jar:/usr/share/elasticsearch/plugins/x-pack/x-pack-core/x-pack-core-*.jar" LicenseVerifier.java

cp ./LicenseVerifier.class org/elasticsearch/license/

jar -cvf x-pack-core-$version.jar ./*

cp x-pack-core-$version.jar /usr/share/elasticsearch/plugins/x-pack/x-pack-core/x-pack-core-$version.jar

