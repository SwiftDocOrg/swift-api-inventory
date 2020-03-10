# swift-api-inventory

`swift-api-inventory` lists the public API symbols of Swift files.

```terminal
$ git clone https://github.com/SwiftDocOrg/SwiftSemantics.git

$ swift run swift-api-inventory SwiftSemantics/Sources | less
struct AssociatedType: Declaration, Hashable, Codable, ExpressibleBySyntax
var AssociatedType.attributes { get }
var AssociatedType.context { get }
var AssociatedType.keyword { get }
var AssociatedType.modifiers { get }
var AssociatedType.name { get }
...

$ swift run swift-api-inventory SwiftSemantics/Sources | wc
     207    1023    8993
```

Because each symbol is printed on its own line,
you can feed the output of `swift-api-inventory` to conventional diffing tools
to determine API changes between different releases of a project.

For example,
here's an API diff between the first beta and latest release candidate of
[Alamofire 5](https://forums.swift.org/t/alamofire-5-one-year-in-the-making-now-in-beta/18865):

```terminal
$ git clone https://github.com/Alamofire/Alamofire.git
$ (cd Alamofire; git co 5.0.0-beta.1; swift run swift-api-inventory Source > ../Alamofire-5.0.0-beta.1.txt)
$ (cd Alamofire; git co 5.0.0-rc.3; swift run swift-api-inventory Source > ../Alamofire-5.0.0-rc.3.txt)
$ diff -u Alamofire-5.0.0-beta.1.txt Alamofire-5.0.0-rc.3.txt | diffstat
 Alamofire-5.0.0-rc.3.txt |  346 ++++++++++++++++++++++++++++++++—————
 1 file changed, 238 insertions(+), 108 deletions(-)
```

<details>

<summary>Example diff between Alamofire 5 RC3 and RC1</summary>

```terminal
$ diff -u Alamofire-5.0.0-rc.1.txt Alamofire-5.0.0-rc.3.txt
```

```diff
— Alamofire-5.0.0-rc.1.txt
+++ Alamofire-5.0.0-rc.3.txt
@@ -77,6 +77,7 @@
 case AFError.ServerTrustFailureReason.revocationCheckFailed(output: Output, options: RevocationTrustEvaluator.Options)
 case AFError.ServerTrustFailureReason.revocationPolicyCreationFailed
 case AFError.ServerTrustFailureReason.settingAnchorCertificatesFailed(status: OSStatus, certificates: [SecCertificate])
+case AFError.ServerTrustFailureReason.trustEvaluationFailed(error: Error?)
 enum AFError.URLRequestValidationFailureReason
 case AFError.URLRequestValidationFailureReason.bodyDataInGETRequest(_: Data)
 case AFError.createURLRequestFailed(error: Error)
@@ -613,13 +614,14 @@
 case URLEncodedFormEncoder.SpaceEncoding.percentEscaped
 case URLEncodedFormEncoder.SpaceEncoding.plusReplaced
 var URLEncodedFormEncoder.allowedCharacters { get set }
+var URLEncodedFormEncoder.alphabetizeKeyValuePairs { get }
 var URLEncodedFormEncoder.arrayEncoding { get }
 var URLEncodedFormEncoder.boolEncoding { get }
 var URLEncodedFormEncoder.dataEncoding { get }
 var URLEncodedFormEncoder.dateEncoding { get }
 func URLEncodedFormEncoder.encode(_: Encodable) throws -> String
 func URLEncodedFormEncoder.encode(_: Encodable) throws -> Data
-init URLEncodedFormEncoder(arrayEncoding: ArrayEncoding, boolEncoding: BoolEncoding, dataEncoding: DataEncoding, dateEncoding: DateEncoding, keyEncoding: KeyEncoding, spaceEncoding: SpaceEncoding, allowedCharacters: CharacterSet)
+init URLEncodedFormEncoder(alphabetizeKeyValuePairs: Bool, arrayEncoding: ArrayEncoding, boolEncoding: BoolEncoding, dataEncoding: DataEncoding, dateEncoding: DateEncoding, keyEncoding: KeyEncoding, spaceEncoding: SpaceEncoding, allowedCharacters: CharacterSet)
```

</details>

Then run the `swift build` command to build your project.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
