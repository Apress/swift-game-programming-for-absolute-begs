import SpriteKit

class TileField : SKNode {
    
    var layout: GridLayout
    
    init(rows: Int, columns: Int, cellWidth: Int, cellHeight: Int) {
        layout = GridLayout(rows: rows, columns: columns, cellWidth: cellWidth, cellHeight: cellHeight)
        super.init()
        layout.target = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTileType(col: Int, row: Int) -> TileType {
        if let obj = layout.at(col, row: row) as? Tile {
            return obj.type
        }
        return .Background
    }
}
