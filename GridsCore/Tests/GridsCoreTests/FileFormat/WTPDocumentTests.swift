//
//  WTPDocumentTests.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import Testing
@testable import GridsCore

@Suite("Document Parsing")
struct WCPDocumentTests {
    @Test("Bare minimum decode")
    func basicDecodeFromString() async throws {
        let source =
"""
name=Geschlossene Erinnerungen
author=Lorelei Weiss
puzzle=1:Tw0
"""
        let file = WTPDocument(reading: source)
        #expect(file.name == "Geschlossene Erinnerungen")
        #expect(file.author == "Lorelei Weiss")
        #expect(file.icon == .generic)
        #expect(file.puzzleCodes == ["1:Tw0"])
    }

    @Test("Decode with icon")
    func decodeFromStringWithIcon() async throws {
        let source =
"""
name=Geschlossene Erinnerungen
author=Lorelei Weiss
icon=2
puzzle=1:Tw0
"""
        let file = WTPDocument(reading: source)
        #expect(file.name == "Geschlossene Erinnerungen")
        #expect(file.author == "Lorelei Weiss")
        #expect(file.icon == .gardens)
        #expect(file.puzzleCodes == ["1:Tw0"])
    }

    @Test("Multiple puzzles (single line)")
    func decodeFromStringWithMultiplePuzzlesSingleLine() async throws {
        let source =
"""
name=Geschlossene Erinnerungen
author=Lorelei Weiss
puzzle=1:Tw0;1:Z6
"""
        let file = WTPDocument(reading: source)
        #expect(file.name == "Geschlossene Erinnerungen")
        #expect(file.author == "Lorelei Weiss")
        #expect(file.icon == .generic)
        #expect(file.puzzleCodes == ["1:Tw0", "1:Z6"])
    }

    @Test("Multiple puzzles (multi line)")
    func decodeFromStringWithMultiplePuzzlesMultiline() async throws {
        let source =
"""
name=Geschlossene Erinnerungen
author=Lorelei Weiss
puzzle=1:Tw0;1:Z6
puzzle=1:Aw0
"""
        let file = WTPDocument(reading: source)
        #expect(file.name == "Geschlossene Erinnerungen")
        #expect(file.author == "Lorelei Weiss")
        #expect(file.icon == .generic)
        #expect(file.puzzleCodes == ["1:Tw0", "1:Z6", "1:Aw0"])
    }

    @Test("Puzzle encodes")
    func encodeFromNewDocument() async throws {
        let file = WTPDocument(
            name: "Geschlossene Erinnerungen",
            author: "Lorelei Weiss",
            icon: .generic,
            puzzleCodes: ["1:Tw0", "1:Z6", "1:Aw0"]
        )
        let encoded = file.encoded()

        let originalFile =
        """
        name=Geschlossene Erinnerungen
        author=Lorelei Weiss
        icon=1
        puzzle=1:Tw0;1:Z6;1:Aw0
        """
        #expect(encoded == originalFile)
    }
}
