import SpriteKit

class TileField : SKNode {
    
    var layout: GridLayout
    
    override init() {
        layout = GridLayout(rows: 1, columns: 1, cellWidth: 0, cellHeight: 0)
        super.init()
    }
    
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
        if col < 0 || col >= layout.columns {
            return .Wall
        }
        return .Background
    }

    func getTileBox(col: Int, row: Int) -> CGRect {
       // if let obj = layout.at(col, row: row) as? Tile {
        //    return obj.box
       // } else {
            let tile = Tile()
            tile.position = layout.toPosition(col, row: row)
            self.addChild(tile)
            let bbox = tile.box
            tile.removeFromParent()
            return bbox
       // }
    }
}
